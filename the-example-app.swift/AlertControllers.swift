
import Foundation
import UIKit

/**
 Factory initializers for UIAlertController subclass.
 Note for testing: UIAlertControllers always set their accessibilityLabel's to the value in their title.
 */
class AlertController: UIAlertController {

    static func credentialSuccess(credentials: ContentfulCredentials) -> AlertController {
        let title = "New space detected"
        let message = """
        You've connected to a new space with id: \(credentials.spaceId) using url deep links.
        A new app session remaining connected to a space starts now and will expire in 48 hours.
        """
        let controller = AlertController(title: title, message: message, preferredStyle: .alert)
        controller.addDismissAction()
        return controller
    }

    static func noContentErrorAlertController(error: ApplicationError) -> AlertController {

        let controller = AlertController(title: error.headline,
                                         message: error.message.string,
                                         preferredStyle: .alert)
        controller.addDismissAction()
        return controller
    }

    func addDismissAction() {
        let action = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
        addAction(action)
    }
}
