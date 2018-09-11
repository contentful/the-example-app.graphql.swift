
import Foundation
import DeepLinkKit
import Apollo

/// ContentfulService is a type that this app uses to manage state related to Contentful such as which locale
/// should be specified in API requests, and which API should be used: preview or delivery. It also adds some additional
/// methods for "diff'ing" the results from the preview and delivery APIs so that the states of resources can be inferred.
class ContentfulService {

    /// A struct that represents the state of the Contentful service at any given time.
    /// One nice property of this type is that since it's a struct, a change to any member variable
    /// is a change to the entity itself. We can use this type in conjunction with a the `StateMachine` type
    /// to observe state changes in all the UI of the application.
    struct State {

        /// The currently selected API that the app is pulling data from.
        var api: API

        /// An enumeration of all the possible API's this ContentfulService can interface with.
        ///
        /// - delivery: A enum representation of the Content Delivery API.
        /// - preview: A enum representation of the Content Preview API.
        public enum API: String {
            case delivery
            case preview

            func title() -> String {
                switch self {
                case .delivery:
                    return "API: Delivery"
                case .preview:
                    return "API: Preview"
                }
            }
        }
    }

    /// The state machine that the app will use to observe state changes and execute relevant updates.
    public let stateMachine: StateMachine<ContentfulService.State>

    /// An instance of ApolloClient for interfacing with the Contentful GraphQL API.
    public let graphQLClient: ApolloClient

    public func setAPI(_ api: ContentfulService.State.API) {
        session.persistAPI(api)
        stateMachine.state.api = api
    }

    /// If connected to the original space which is maintained by Contentful and has read-only access this will return `true`.
    public func isConnectedToDefaultSpace() -> Bool {
        return credentials.spaceId == ContentfulCredentials.default.spaceId
            && credentials.deliveryAPIAccessToken == ContentfulCredentials.default.deliveryAPIAccessToken
            && credentials.previewAPIAccessToken == ContentfulCredentials.default.previewAPIAccessToken
    }

    let session: Session
    let credentials: ContentfulCredentials

    init(session: Session, credentials: ContentfulCredentials, state: State) {
        self.session = session
        self.credentials = credentials

        // GraphQL ApolloClient.
        let urlSessionCongif: URLSessionConfiguration = .default
        urlSessionCongif.httpAdditionalHeaders = ["Authorization": "Bearer \(credentials.deliveryAPIAccessToken)"]
        let url = URL(string: "https://graphql.contentful.com/content/v1/spaces/\(credentials.spaceId)/environments/master")!
        graphQLClient = ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: urlSessionCongif))

        stateMachine = StateMachine<State>(initialState: state)
    }
}

extension ContentfulService.State.API: Equatable {}

func ==(lhs: ContentfulService.State.API, rhs: ContentfulService.State.API) -> Bool {
    switch (lhs, rhs) {
    case (.delivery, .delivery):    return true
    case (.preview, .preview):      return true
    default:                        return false
    }
}

extension Date {

    func isEqualTo(_ date: Date) -> Bool {
        // Strip units smaller than seconds from the date
        let comparableComponenets: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second, .timeZone]
        guard let newSelf = Calendar.current.date(from: Calendar.current.dateComponents(comparableComponenets, from: self)) else {
            fatalError("Failed to strip milliseconds from Date object")
        }
        guard let newComparisonDate = Calendar.current.date(from: Calendar.current.dateComponents(comparableComponenets, from: date)) else {
            fatalError("Failed to strip milliseconds from Date object")
        }

        return newSelf == newComparisonDate
    }
}

