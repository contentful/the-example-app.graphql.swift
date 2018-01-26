
import Foundation
import UIKit

class ConnectedSpaceViewController: UITableViewController, CustomNavigable {

    var services: Services!

    static func new(services: Services) -> ConnectedSpaceViewController {
        let viewController = UIStoryboard.init(name: String(describing: ConnectedSpaceViewController.self), bundle: nil).instantiateInitialViewController() as! ConnectedSpaceViewController
        viewController.services = services

        return viewController
    }

    func localizeTextsViaStateObservations() {
        // Update all text labels.
        services.contentful.stateMachine.addTransitionObservationAndObserveInitialState { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.title = "settingsLabel".localized(contentfulService: strongSelf.services.contentful)
            strongSelf.usingSessionCredentialsLabel.text = "usingSessionCredentialsLabel".localized(contentfulService: strongSelf.services.contentful)
            strongSelf.connectedToSpaceLabel.text = "connectedToSpaceLabel".localized(contentfulService: strongSelf.services.contentful)
            strongSelf.updateButtonState()
        }
    }

    func updateLabelWithCurrentSession() {
        let _ = services.contentful.client.fetchSpace().then { [weak self] space in
            DispatchQueue.main.async {
                self?.currentlyConnectedSpaceLabel.text = space.name + " (" + space.id + ")"
            }
        }
    }

    func updateButtonState() {
        resetCredentialsButton.setTitle("resetCredentialsLabel".localized(contentfulService: services.contentful), for: .normal)
        resetCredentialsButton.isEnabled = !services.contentful.isConnectedToDefaultSpace()
    }

    // MARK: CustomNavigable

    var hasCustomToolbar: Bool {
        return false
    }

    var prefersLargeTitles: Bool {
        return false
    }

    // MARK: UIViewController

    override func loadView() {
        super.loadView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        tableView.separatorStyle = .none
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha:1.0)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        updateLabelWithCurrentSession()
        updateButtonState()
    }

    // MARK: Interface Builder

    @IBOutlet weak var connectedToSpaceLabel: UILabel!
    @IBOutlet weak var currentlyConnectedSpaceLabel: UILabel!
    @IBOutlet weak var usingSessionCredentialsLabel: UILabel!

    @IBOutlet weak var resetCredentialsButton: UIButton!

    @IBAction func resetCredentialsButtonAction(_ sender: Any) {
        let defaultCredentials = ContentfulCredentials.default
        services.contentful = ContentfulService(session: services.session,
                                                credentials: defaultCredentials,
                                                api: services.contentful.stateMachine.state.api,
                                                editorialFeaturesEnabled: services.contentful.stateMachine.state.editorialFeaturesEnabled)
        // TODO: Dry with other session save code.
        services.session.spaceCredentials = defaultCredentials
        services.session.persistCredentials()
        updateLabelWithCurrentSession()
        updateButtonState()
    }
}