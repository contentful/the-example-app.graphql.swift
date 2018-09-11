
import Foundation
import UIKit
import Alamofire
import AlamofireImage

class LessonImageTableViewCell: UITableViewCell, CellConfigurable {

    typealias ItemType = LessonImageFragment

    func configure(item: LessonImageFragment) {
        guard let asset = item.image else {
            return
        }
        imageCaptionLabel.text = item.caption
        // TODO:
//        lessonImageView.setImageToNaturalHeight(fromAsset: asset, heightConstraint: lessonImageHeightConstraint)
    }

    func resetAllContent() {
        lessonImageView.image = nil
        lessonImageHeightConstraint.constant = 0.0
        imageCaptionLabel.text = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        isUserInteractionEnabled = false
        selectionStyle = .none
    }

    @IBOutlet weak var lessonImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lessonImageView: UIImageView!

    @IBOutlet weak var imageCaptionLabel: UILabel! {
        didSet {
            imageCaptionLabel.font = UIFont.italicSystemFont(ofSize: 14.0)
        }
    }
}
