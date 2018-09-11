
import Foundation
import UIKit
import DeepLinkKit


/// This class contains all the logic necessary to route the app to a specific screen with the proper underlying navigation stack and application state.
/// This class also maps URL strings [deep links] to said routes and will update the application state based on relevant url parameters parsed from deep links.
final class Router {

    /// A root container view controller to contain the application and simplify navigation transitions.
    let rootViewController: RootViewController

    let services: Services

    /// Router depends on DPLDeepLinkRouter to do pattern matching and routing for the urls that the operating system forwards
    /// the application. It also provides niceties for parsing url arguments.
    let deepLinkRouter: DPLDeepLinkRouter

    init(services: Services, deepLinkRouter: DPLDeepLinkRouter) {
        self.services = services
        self.rootViewController = RootViewController()

        // Register deep link routes.
        self.deepLinkRouter = deepLinkRouter
        self.deepLinkRouter.registerRoutes(routes: routes())

        // Show view controllers.
        showTabBarController()
    }


    var tabBarController: TabBarController? {
        return rootViewController.viewController as? TabBarController
    }

    func showTabBarController(then completion: ((TabBarController) -> Void)? = nil) {
        if let tabBarController = self.tabBarController {
            completion?(tabBarController)
            return
        }
        let tabBarController = TabBarController(services: services)
        rootViewController.set(viewController: tabBarController)
    }

    func showBlockingLoadingModal() -> UIView {
        let loadingOverlay = UIView.loadingOverlay(frame: rootViewController.view.frame)

        OperationQueue.main.addOperation { [unowned self] in
            self.rootViewController.view.addSubview(loadingOverlay)
        }
        return loadingOverlay
    }

    // MARK: DeepLink Parameters

    func apiState(from deepLink: DPLDeepLink) -> ContentfulService.State.API {
        guard let api = deepLink.queryParameters["api"] as? String else {
            // Return current state if no link parameters present.
            return services.contentful.stateMachine.state.api
        }

        if api == "cpa" {
            return .preview
        } else if api == "cda" {
            return .delivery
        }
        return .delivery
    }


    // MARK: Routes

    /// All the url routes of the application and their corresponding router handler.
    /// This is an array of tuples rather than a dictionary since the order of the route registration is
    /// respected by DPLDeepLinkRouter: i.e. the first route that a url matches will be the route for which
    /// the handler is called. This is why the wildcard route ".*" is last.
    func routes() -> [(String, DPLRouteHandlerBlock)] {
        return [

            // All courses route.
            ("courses", { [unowned self] _ in

                self.showTabBarController() { tabBarController in
                    tabBarController.showCoursesViewController()
                }
            }),

            // Route to a specific course.
            ("courses/:slug", { [unowned self] deepLink in
                guard let deepLink = deepLink else { return }

                self.showTabBarController() { tabBarController in
                    tabBarController.showCoursesViewController() { coursesViewController in
                        guard let slug = deepLink.routeParameters["slug"] as? String else { return }
                        let courseViewController = CourseViewController(course: nil, services: self.services)
                        coursesViewController.navigationController?.pushViewController(courseViewController, animated: false)
                        courseViewController.fetchCourseWithSlug(slug)
                    }
                }
            }),

            // Route to a specific lesson in a course.
            ("courses/:courseSlug/lessons/:lessonSlug", { [unowned self] deepLink in
                guard let deepLink = deepLink else { return }

                self.showTabBarController() { tabBarController in
                    tabBarController.showCoursesViewController { coursesViewController in
                        guard let courseSlug = deepLink.routeParameters["courseSlug"] as? String else { return }
                        let lessonSlug = deepLink.routeParameters["lessonSlug"] as? String

                        // Push Course View Controller
                        let courseViewController = CourseViewController(course: nil, services: self.services)
                        coursesViewController.navigationController?.pushViewController(courseViewController, animated: false)
                        // Present the lessons view controller even before making the network request.
                        courseViewController.pushLessonsCollectionViewAndShowLesson(at: 0, animated: false)
                        courseViewController.fetchCourseWithSlug(courseSlug, showLessonWithSlug: lessonSlug)
                    }
                }
            }),

            // Categories route.
            ("courses/categories/:categorySlug", { [unowned self] deepLink in
                guard let deepLink = deepLink else { return }

                self.showTabBarController() { tabBarController in
                    tabBarController.showCoursesViewController { coursesViewController in
                        guard let categorySlug = deepLink.routeParameters["categorySlug"] as? String else { return }

                        coursesViewController.onCategoryAppearance = { categories in
                            if let category = categories.filter({ $0.slug == categorySlug }).first {
                                coursesViewController.select(category: category)
                            }
                        }
                    }
                }
            }),

            // Home. "." resolves to the empty route "the-example-app.swift://"
            (".*", { [unowned self] deepLink in
                guard let deepLink = deepLink else { return }

                var isHomeRoute = deepLink.url.host == nil
                if let host = deepLink.url.host, host.isEmpty == true {
                    isHomeRoute = true
                }
                // Home route.
                if isHomeRoute {

                    self.showTabBarController() { tabBarController in
                        tabBarController.showHomeViewController()
                    }
                } else {
                    // Other non-supported routes.
                    let error = NoContentError.invalidRoute(contentfulService: self.services.contentful, route: deepLink.url.host!, fontSize: 14.0)
                    let alertController = AlertController.noContentErrorAlertController(error: error)
                    self.rootViewController.present(alertController, animated: true, completion: nil)
                }
            })
        ]
    }
}

extension DPLDeepLinkRouter {

    // Register an array of tuples rather than using a dictionary to ensure
    // that the registration order is respected as DeepLinkKit respects this ordering.
    func registerRoutes(routes: [(String, DPLRouteHandlerBlock)]) {
        for (route, handler) in routes {
            self.register(handler, forRoute: route)
        }
    }
}
