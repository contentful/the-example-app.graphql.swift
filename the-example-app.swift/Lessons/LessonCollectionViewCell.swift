
import Foundation
import UIKit

struct LessonViewModel {

    let lesson: LessonFragment
    let services: Services
}

final class LessonCollectionViewCell: UICollectionViewCell, CellConfigurable {

    // The lesson is optional so that we can deep link to a cell and show a loading state.
    typealias ItemType = LessonViewModel?

    func configure(item: LessonViewModel?) {
        if let item = item {
            guard let modules = item.lesson.modulesCollection?.items, modules.count > 0 else {
                let error = NoContentError.noModules(contentfulService: item.services.contentful,
                                                     route: "",
                                                     fontSize: 14.0)
                let errorModel = ErrorTableViewCell.Model(error: error, services: item.services)
                tableViewDataSource = ErrorTableViewDataSource(model: errorModel)
                tableView.delegate = nil
                return
            }

            let dataSource = LessonModulesDataSource(lessonViewModel: item)
            accessibilityLabel = item.lesson.title
            tableViewDataSource = dataSource
            tableView.delegate = dataSource
        } else {
            tableViewDataSource = LoadingTableViewDataSource()
            tableView.delegate = nil
        }
    }

    func resetAllContent() {
        accessibilityLabel = nil

        tableViewDataSource = nil
        tableView.delegate = nil
    }

    var tableViewDataSource: UITableViewDataSource? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView?.dataSource = self?.tableViewDataSource
                self?.tableView?.reloadData()
            }
        }
    }

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.separatorStyle = .none
            tableView.separatorColor = .clear

            tableView.registerNibFor(LoadingTableViewCell.self)
            tableView.registerNibFor(LessonCopyTableViewCell.self)
            tableView.registerNibFor(LessonSnippetsTableViewCell.self)
            tableView.registerNibFor(LessonImageTableViewCell.self)
            tableView.registerNibFor(ErrorTableViewCell.self)
        }
    }
}

class LessonModulesDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

    let lessonViewModel: LessonViewModel

    let copyCellFactory = TableViewCellFactory<LessonCopyTableViewCell>()
    let snippetsCellFactory = TableViewCellFactory<LessonSnippetsTableViewCell>()
    let imageCellFactory = TableViewCellFactory<LessonImageTableViewCell>()

    init(lessonViewModel: LessonViewModel) {
        self.lessonViewModel = lessonViewModel
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessonViewModel.lesson.modulesCollection?.items.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell

        if let markdownModule = lessonViewModel.lesson.modulesCollection?.items[indexPath.item]?.fragments.lessonCopyFragment {
            cell = copyCellFactory.cell(for: markdownModule, in: tableView, at: indexPath)

        } else if let snippetsModule = lessonViewModel.lesson.modulesCollection?.items[indexPath.item]?.fragments.lessonCodeSnippetFragment {
            cell = snippetsCellFactory.cell(for: snippetsModule, in: tableView, at: indexPath)

        } else if let imageModule = lessonViewModel.lesson.modulesCollection?.items[indexPath.item]?.fragments.lessonImageFragment {
            cell = imageCellFactory.cell(for: imageModule, in: tableView, at: indexPath)

        } else {
            fatalError()
        }
        return cell
    }
}
