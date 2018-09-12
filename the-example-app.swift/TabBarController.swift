
import Foundation
import UIKit

protocol TabBarTabViewController {

    var tabItem: UITabBarItem { get }
}

class TabBarController: UITabBarController {

    let services: Services

    init(services: Services) {
        self.services = services

        super.init(nibName: nil, bundle: nil)

        let refreshButton = UIBarButtonItem(image: UIImage(named: "navbar-icon-refresh"), style: .plain, target: self, action: #selector(TabBarController.refresh))
        let navBarButton = NavBarButton(persistsOnPush: true, button: refreshButton)

        let viewControllers: [UIViewController] = [
            TabBarNavigationController(rootViewController: HomeLayoutTableViewController(services: services), services: services, navBarButton: navBarButton),
            TabBarNavigationController(rootViewController: CoursesTableViewController(services: services), services: services, navBarButton: navBarButton),
        ]

        self.viewControllers = viewControllers
        selectedIndex = 0
    }

    @objc func refresh() {
        services.contentful.stateMachine.triggerObservations()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func showHomeViewController() {
        selectedIndex = 0
    }

    public func showCoursesViewController(then completion: ((CoursesTableViewController) -> Void)? = nil) {
        selectedIndex = 1
        let coursesViewController = (viewControllers![1] as! TabBarNavigationController).viewControllers.first as! CoursesTableViewController
        (viewControllers![1] as! TabBarNavigationController).popToRootViewController(animated: false)
        completion?(coursesViewController)
    }
}
