
import Foundation
import UIKit

// https://stackoverflow.com/a/31744226/4068264
extension String {

    /// Using the locale from the input ContentfulService, this method returns the localized value for the receiving
    /// localization key. If there is no value for the receiving key for the currently selected locale, this will walk the fallback path if it exists.
    /// If no fallback locale is configured, this method will return the value in American English.
    func localized() -> String {

        let path = Bundle.main.path(forResource: "en-US", ofType: "lproj")!

        let bundle = Bundle(path: path)
        let string = NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")

        return string
    }
}
