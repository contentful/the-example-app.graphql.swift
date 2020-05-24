
import Foundation
import UIKit
import Apollo

class HomeLayoutTableViewController: UIViewController, TabBarTabViewController, UITableViewDelegate, UITableViewDataSource, CustomNavigable {

    var tabItem: UITabBarItem {
        return UITabBarItem(title: "homeLabel".localized(),
                            image: UIImage(named: "tabbar-icon-home"),
                            selectedImage: nil)
    }

    let services: Services

    // Data model for this view controller.
    var homeLayout: LayoutFragment?

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
    let highlighteCourseCellFactory = TableViewCellFactory<LayoutHighlightedCourseTableViewCell>()
    let heroImageCellFactory = TableViewCellFactory<LayoutHeroImageTableViewCell>()
    let layoutCopyDefaultCellFactory = TableViewCellFactory<LayoutCopyDefaultTableViewCell>()
    let layoutCopyEmphasizedCellFactory = TableViewCellFactory<LayoutCopyEmphasizedTableViewCell>()

    var query: HomeQuery {
        return HomeQuery(slug: "home")
    }

    // Requests.
    var layoutRequest: Cancellable?

    // MARK: CustomNavigable

    var hasCustomToolbar: Bool {
        return false
    }

    var prefersLargeTitles: Bool {
        return true
    }

    init(services: Services) {
        self.services = services
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "Home", image: nil, selectedImage: nil)

        self.title = "The iOS example app"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("Deallocated HomeViewController")
    }

    // State change reactions.
    var stateObservationToken: String?

    var contentfulServiceStateObservatinToken: String?

    func addStateObservations() {
        stateObservationToken = services.contentful.stateMachine.addTransitionObservationAndObserveInitialState { [unowned self] _ in
            DispatchQueue.main.async {
                self.fetchLayoutFromContenful()
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

    func fetchLayoutFromContenful() {
        tableViewDataSource = LoadingTableViewDataSource()

        // Cancel the previous request before making a new one.
        layoutRequest?.cancel()
        layoutRequest = services.contentful.graphQLClient.fetch(query: self.query) { [unowned self] response in
            switch response {
            case .success(let result):
                if let data = result.data {
                    guard let layoutCollection = data.layoutCollection, layoutCollection.items.count > 0 else {
                        self.setNoHomeLayoutErrorDataSource()
                        return
                    }
                    guard let modules = layoutCollection.items.first!?.fragments.layoutFragment.contentModulesCollection?.items, modules.count > 0 else {
                        self.setNoModulesDataSource()
                        return
                    }
                    self.homeLayout = layoutCollection.items.first!?.fragments.layoutFragment
                    self.tableViewDataSource = self
                    DispatchQueue.main.async {
                        self.tableView.delegate = self
                    }
                }

            case .failure(let error):
                let errorModel = ErrorTableViewCell.Model(error: error, services: self.services)
                self.tableViewDataSource = ErrorTableViewDataSource(model: errorModel)
                return // TODO: return?
            }
        }
    }

    func setNoModulesDataSource() {
        let error = NoContentError.noModules(contentfulService: services.contentful,
                                             route: "",
                                             fontSize: 14.0)
        let errorModel = ErrorTableViewCell.Model(error: error, services: services)
        tableViewDataSource = ErrorTableViewDataSource(model: errorModel)
        DispatchQueue.main.async { [unowned self] in
            self.tableView.delegate = nil
        }
    }

    func setNoHomeLayoutErrorDataSource() {
        let error = NoContentError.noHomeLayout(contentfulService: services.contentful,
                                                route: "",
                                                fontSize: 14.0)
        let errorModel = ErrorTableViewCell.Model(error: error, services: services)
        tableViewDataSource = ErrorTableViewDataSource(model: errorModel)
        DispatchQueue.main.async { [unowned self] in
            self.tableView.delegate = nil
        }
    }


    // MARK: UIViewController

    override func loadView() {
        tableView = UITableView(frame: .zero)

        tableView.registerNibFor(LayoutHighlightedCourseTableViewCell.self)
        tableView.registerNibFor(LayoutCopyDefaultTableViewCell.self)
        tableView.registerNibFor(LayoutCopyEmphasizedTableViewCell.self)
        tableView.registerNibFor(LayoutHeroImageTableViewCell.self)

        tableView.registerNibFor(LoadingTableViewCell.self)
        tableView.registerNibFor(ErrorTableViewCell.self)
        
        // Enable table view cells to be sized dynamically based on inner content.
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 345
        tableView.accessibilityLabel = "Home"
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addStateObservations()
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Analytics.shared.logViewedRoute("/", spaceId: services.contentful.credentials.spaceId)
    }
    
    // MARK: UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeLayout?.contentModulesCollection?.items.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: UITableViewCell

        if let highlightedCourse = homeLayout?.contentModulesCollection?.items[indexPath.row]?.fragments.layoutHighlightedCourseFragment,
            let course = highlightedCourse.course {

            let model = LayoutHighlightedCourseTableViewCell.Model(highlightedCourse: highlightedCourse) { [unowned self] in
                let courseViewController = CourseViewController(course: course.fragments.courseFragment, services: self.services)
                self.navigationController?.pushViewController(courseViewController, animated: true)
            }
            cell = highlighteCourseCellFactory.cell(for: model, in: tableView, at: indexPath)

        } else if let layoutCopy = homeLayout?.contentModulesCollection?.items[indexPath.row]?.fragments.layoutCopyFragment {
            cell = layoutCopy.visualStyle == "Emphasized" ? layoutCopyEmphasizedCellFactory.cell(for: layoutCopy, in: tableView, at: indexPath) : layoutCopyDefaultCellFactory.cell(for: layoutCopy, in: tableView, at: indexPath)

        } else if let layoutHeroImage = homeLayout?.contentModulesCollection?.items[indexPath.row]?.fragments.layoutHeroImageFragment {
            cell = heroImageCellFactory.cell(for: layoutHeroImage, in: tableView, at: indexPath)

        } else {
            fatalError()
        }
        return cell
    }


    // MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 1 else { return }

        guard let highlightedCourse = homeLayout?.contentModulesCollection?.items[indexPath.row]?.fragments.layoutHighlightedCourseFragment,
            let course = highlightedCourse.course else { return }

        let courseViewController = CourseViewController(course: course.fragments.courseFragment, services: self.services)
        navigationController?.pushViewController(courseViewController, animated: true)
    }
}
