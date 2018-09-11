
import Foundation

/// A small wrapper around the credentials for a space.
struct ContentfulCredentials: Codable, Equatable {

    static func ==(lhs: ContentfulCredentials, rhs: ContentfulCredentials) -> Bool {
        return lhs.spaceId == rhs.spaceId && lhs.deliveryAPIAccessToken == rhs.deliveryAPIAccessToken && lhs.previewAPIAccessToken == rhs.previewAPIAccessToken
    }

    static let defaultDomainHost = "contentful.com"

    let spaceId: String
    let deliveryAPIAccessToken: String
    let previewAPIAccessToken: String
    let domainHost: String

    /**
     * Pulls the default space credentials from the Example App Space owned by Contentful.
     */
    static let `default`: ContentfulCredentials = {
        guard let bundleInfo = Bundle.main.infoDictionary else { fatalError() }

        let spaceId = bundleInfo["CONTENTFUL_SPACE_ID"] as! String
        let deliveryAPIAccessToken = bundleInfo["CONTENTFUL_DELIVERY_TOKEN"] as! String
        let previewAPIAccessToken = bundleInfo["CONTENTFUL_PREVIEW_TOKEN"] as! String

        let credentials = ContentfulCredentials(spaceId: spaceId,
                                                deliveryAPIAccessToken: deliveryAPIAccessToken,
                                                previewAPIAccessToken: previewAPIAccessToken,
                                                domainHost: ContentfulCredentials.defaultDomainHost)
        return credentials
    }()

}

@discardableResult internal func +=<K, V> (left: [K: V], right: [K: V]) -> [K: V] {
    var result = left
    right.forEach { (key, value) in result[key] = value }
    return result
}

@discardableResult internal func +<K, V> (left: [K: V], right: [K: V]) -> [K: V] {
    return left += right
}
