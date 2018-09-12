
import Foundation

/// A class that acts as a service bus, bussing around services down through the various components of the app.
class Services {

    public var session: Session
    
    public var contentful: ContentfulService {
        didSet {
            contentfulStateMachine.state = contentful
        }
    }

    public let contentfulStateMachine: StateMachine<ContentfulService>

    public func resetCredentialsAndResetLocaleIfNecessary() {
        let defaultCredentials = ContentfulCredentials.default

        // Retain state from last ContentfulService, but ensure we are using a locale that is available in default space.
        let state = contentful.stateMachine.state
        contentful = ContentfulService(session: session,
                                       credentials: defaultCredentials,
                                       state: state)

        session.spaceCredentials = defaultCredentials
        session.persistCredentials()
    }

    init(session: Session) {
        self.session = session
        let spaceCredentials = session.spaceCredentials

        let api = ContentfulService.State.API(rawValue: session.persistedAPIRawValue() ?? ContentfulService.State.API.delivery.rawValue)!
        let state = ContentfulService.State(api: api)
        contentful = ContentfulService(session: session,
                                       credentials: spaceCredentials,
                                       state: state)
        contentfulStateMachine = StateMachine(initialState: contentful)
    }
}
