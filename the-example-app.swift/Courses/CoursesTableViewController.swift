        
import Foundation
import UIKit
import Apollo

extension CategoryFragment: Equatable {
    public static func ==(lhs: CategoryFragment, rhs: CategoryFragment) -> Bool {
        return lhs.sys.id == rhs.sys.id
    }
}

class CoursesTableViewController: UIViewController, TabBarTabViewController, UITableViewDataSource, UITableViewDelegate, CategorySelectorDelegate {

    var tabItem: UITabBarItem {
        return UITabBarItem(title: "coursesLabel".localized(),
                            image: UIImage(named: "tabbar-icon-courses"),
                            selectedImage: nil)
    }

    init(services: Services) {
        self.services = services
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let services: Services

    // Data model for this view controller.
    var coursesSectionModel: CoursesSectionModel = .loading {
        didSet {
            updateTableViewDelegate()
        }
    }

    enum CoursesSectionModel {
        case loaded([CourseFragment])
        case loading
        case errored(Error)
    }

    let coursesSectionIndex: Int = 1

    var categories: [CategoryFragment]?

    var selectedCategory: CategoryFragment?

    var onCategoryAppearance: (([CategoryFragment]) -> Void)?

    // We must retain the data source.
    var tableViewDataSource: UITableViewDataSource? {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.tableView.dataSource = self.tableViewDataSource
                self.tableView.reloadData()
            }
        }
    }

    // Table view and cell rendering.
    var tableView: UITableView!
    let coursesCellFactory = TableViewCellFactory<CourseTableViewCell>()
    let categorySelectorCellFactory = TableViewCellFactory<CategorySelectorTableViewCell>()

    // Requests.
    var coursesRequest: Cancellable?
    var categoriesRequest: Cancellable?

    // State change reactions.
    var stateObservationToken: String?
    var contentfulServiceStateObservatinToken: String?

    func addStateObservations() {
        stateObservationToken = services.contentful.stateMachine.addTransitionObservationAndObserveInitialState { [unowned self] _ in
            DispatchQueue.main.async {
                self.title = "coursesLabel".localized()
                self.fetchCategoriesFromContentful()
            }
        }

        // Observation for when we change spaces.
        contentfulServiceStateObservatinToken = services.contentfulStateMachine.addTransitionObservation { [unowned self] _ in
            DispatchQueue.main.async {
                self.removeStateObservations()
                self.addStateObservations()
            }
        }
    }

    func removeStateObservations() {
        if let token = stateObservationToken {
            services.contentful.stateMachine.stopObserving(token: token)
            stateObservationToken = nil
        }

        if let token = contentfulServiceStateObservatinToken {
            services.contentfulStateMachine.stopObserving(token: token)
            contentfulServiceStateObservatinToken = nil
        }
    }

    func fetchCategoriesFromContentful() {
        tableViewDataSource = LoadingTableViewDataSource()

        // Cancel the previous requests before making a new one.
        categoriesRequest?.cancel()
        coursesRequest?.cancel()

        categoriesRequest = services.contentful.graphQLClient.fetch(query: CategoriesQuery()) { [unowned self] response in
            self.categoriesRequest = nil

            switch response {
            case .success(let result):
            guard let categories = result.data?.categoryCollection?.items,
                categories.count > 0
            else {
                self.setNoCategoriesErrorDataSource()
                return
            }

            self.categories = categories.compactMap { $0?.fragments.categoryFragment }

            case .failure(let error):
                let errorModel = ErrorTableViewCell.Model(error: error, services: self.services)
                self.tableViewDataSource = ErrorTableViewDataSource(model: errorModel)
            }

            // Call method for deep linking to a category.
            self.onCategoryAppearance?(self.categories!)
            self.onCategoryAppearance = nil

            self.tableViewDataSource = self
            self.fetchCoursesFromContentful()
        }
    }

    func fetchCoursesFromContentful() {
        // Show loading state by settting the data source to nil.
        coursesSectionModel = .loading
        reloadCoursesSection()

        // Cancel the previous request before making a new one.
        coursesRequest?.cancel()

        // Different queries have different callbacks with Apollo because the Generic `GraphQLQuery` protocol
        // has different associated types for different concrete queries which implement the protocol.
        if let selectedCategory = selectedCategory {
            let query = CoursesByCategoryWithIdQuery(categoryId: selectedCategory.sys.id)
            coursesRequest = services.contentful.graphQLClient.fetch(query: query) { [unowned self] response in
                switch response {
                case .success(let result):
                    guard let courseCollection = result.data?.category?.linkedFrom?.entryCollection,
                        courseCollection.items.count > 0
                    else {
                        self.setNoCoursesErrorDataSource()
                        return
                    }

                    self.coursesSectionModel = CoursesSectionModel.loaded(
                        courseCollection.items.compactMap { $0?.fragments.courseFragment }
                    )

                case .failure(let error):
                    self.coursesSectionModel = CoursesSectionModel.errored(error)
                    self.reloadCoursesSection()
                }

                self.reloadCoursesSection()
            }
        } else {
            coursesRequest = services.contentful.graphQLClient.fetch(query: CoursesQuery()) { [unowned self] response in
                switch response {
                case .success(let result):
                    guard let courseCollection = result.data?.courseCollection,
                        courseCollection.items.count > 0
                    else {
                        self.setNoCoursesErrorDataSource()
                        return
                    }

                    self.coursesSectionModel = CoursesSectionModel.loaded(
                        courseCollection.items.compactMap { $0?.fragments.courseFragment }
                    )

                case .failure(let error):
                    self.coursesSectionModel = CoursesSectionModel.errored(error)
                    self.reloadCoursesSection()
                }

                self.reloadCoursesSection()
            }
        }
    }

    func setNoCategoriesErrorDataSource() {
        let error = NoContentError.noCategories(contentfulService: services.contentful,
                                                route: "category",
                                                fontSize: 14.0)
        let errorModel = ErrorTableViewCell.Model(error: error, services: services)
        tableViewDataSource = ErrorTableViewDataSource(model: errorModel)
    }

    func setNoCoursesErrorDataSource() {
        let error = NoContentError.noCourses(contentfulService: services.contentful,
                                             route: "course",
                                             fontSize: 14.0)
        let errorModel = ErrorTableViewCell.Model(error: error, services: services)
        tableViewDataSource = ErrorTableViewDataSource(model: errorModel)
    }

    func reloadCoursesSection() {
        // Guard against crash for updating a table view section that is not currently being rendered.
        guard categoriesRequest == nil else { return }

        DispatchQueue.main.async { [unowned self] in
            guard self === self.tableView.dataSource else { return }
            guard self.tableView.numberOfSections > self.coursesSectionIndex else { return }

            self.tableView.reloadSections(IndexSet(integer: self.coursesSectionIndex), with: UITableView.RowAnimation.automatic)
        }
    }

    func updateTableViewDelegate() {
        DispatchQueue.main.async { [weak self] in
            if let strongSelf = self, case .loaded = strongSelf.coursesSectionModel {
                strongSelf.tableView.delegate = strongSelf
            } else {
                self?.tableView.delegate = nil
            }
        }
    }

    // MARK: CategorySelectorDelegate

    public func select(category: CategoryFragment?) {
        selectedCategory = category
        fetchCoursesFromContentful()

        // TODO:
//        if let selection = selectedCategory {
//            Analytics.shared.logViewedRoute("/courses/\(selection.slug)", spaceId: services.contentful.credentials.spaceId)
//        }
    }

    func didTapCategory(_ category: CategoryFragment?) {
        guard selectedCategory != category else { return }

        select(category: category)
    }

    // MARK: UIViewController

    override func loadView() {
        tableView = UITableView(frame: .zero)

        tableView.accessibilityLabel = "Courses"

        tableView.registerNibFor(CategorySelectorTableViewCell.self)
        tableView.registerNibFor(CourseTableViewCell.self)
        tableView.registerNibFor(LoadingTableViewCell.self)
        tableView.registerNibFor(ErrorTableViewCell.self)

        // Enable table view cells to be sized dynamically based on inner content.
        tableView.rowHeight = UITableView.automaticDimension
        // Importantly, the estimated height is the height of the CategorySelectorTableViewCell.
        // This prevents a bug where the layout constraints break and print to the console.
        tableView.estimatedRowHeight = 60
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addStateObservations()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTableViewDelegate()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableView.delegate = nil
    }

    // MARK: UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1

        // The section that displays courses has it's own loading state, so return 1 if there are no courses.
        case coursesSectionIndex:
            if case .loaded(let courses) = coursesSectionModel {
                return courses.count
            }
            return 1

        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        switch indexPath.section {
        case 0:
            let cellModel = CategorySelectorTableViewCell.Model(contentfulService: services.contentful,
                                                                categories: categories,
                                                                delegate: self,
                                                                selectedCategory: selectedCategory)
            cell = categorySelectorCellFactory.cell(for: cellModel, in: tableView, at: indexPath)

        case coursesSectionIndex:
            cell = cellInCoursesSection(in: tableView, at: indexPath)

        default: fatalError()
        }
        return cell
    }

    func cellInCoursesSection(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        switch coursesSectionModel {
        case .loaded(let courses):
            let course = courses[indexPath.item]
            let model = CourseTableViewCell.Model(contentfulService: services.contentful,
                                                  course: course,
                                                  backgroundColor: color(for: indexPath.row)) { [unowned self] in
                                                    let courseViewController = CourseViewController(course: course, services: self.services)
                                                    self.navigationController?.pushViewController(courseViewController, animated: true)
            }
            cell = coursesCellFactory.cell(for: model, in: tableView, at: indexPath)
        case .loading:
            // Return a loading cell.
            cell = TableViewCellFactory<LoadingTableViewCell>().cell(for: nil, in: tableView, at: indexPath)
        case .errored(let error):
            let errorModel = ErrorTableViewCell.Model(error: error, services: services)
            cell = TableViewCellFactory<ErrorTableViewCell>().cell(for: errorModel, in: tableView, at: indexPath)
        }
        return cell
    }

    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == coursesSectionIndex else { return }

        guard case .loaded(let courses) = coursesSectionModel else {
            fatalError()
        }
        let course = courses[indexPath.item]
        let courseViewController = CourseViewController(course: course, services: services)
        navigationController?.pushViewController(courseViewController, animated: true)
    }

    func color(for index: Int) -> UIColor {
        switch index % 2 {
        case 0:
            return UIColor(red: 0.33, green: 0.38, blue: 0.44, alpha: 1.0)
        case 1:
            return UIColor(red: 0.04, green: 0.67, blue: 0.46, alpha: 1.0)
        default:
            return UIColor(red: 0.33, green: 0.38, blue: 0.44, alpha: 1.0)
        }
    }
}
