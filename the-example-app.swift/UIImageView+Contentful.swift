
import Foundation
import UIKit
import AlamofireImage
import Contentful

extension UIImageView {

    func setImageToNaturalHeight(fromAsset asset: AssetFragment,
                                 additionalOptions: [ImageOption] = [],
                                 heightConstraint: NSLayoutConstraint? = nil) {

        // Get the current width of the cell and see if it is wider than the screen.
        guard let w = asset.width else { return }
        guard let h = asset.height else { return }
        let (width, height) = (Double(w), Double(h))

        // Use scale to get the pixel size of the image view.
        let scale = UIScreen.main.scale
        let viewWidthInPx = Double(frame.width * scale)
        let percentageDifference = viewWidthInPx / width

        let viewHeightInPoints = height * percentageDifference / Double(scale)
        let viewHeightInPx = viewHeightInPoints * Double(scale)

        heightConstraint?.constant = CGFloat(round(viewHeightInPoints))

        let imageOptions: [ImageOption] = [
            .formatAs(.jpg(withQuality: .asPercent(100))),
            .width(UInt(viewWidthInPx)),
            .height(UInt(viewHeightInPx)),
        ] + additionalOptions

        let url = try! asset.url!.url(with: imageOptions)

        // Use AlamofireImage extensons to fetch the image and render the image veiw.
        af_setImage(withURL: url,
                    placeholderImage: nil,
                    imageTransition: .crossDissolve(0.5),
                    runImageTransitionIfCached: true)

    }
}
