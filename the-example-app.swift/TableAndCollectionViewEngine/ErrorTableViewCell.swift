
import Foundation
import UIKit

class ErrorTableViewCell: UITableViewCell, CellConfigurable {

    struct Model {
        let error: Error
        let services: Services
    }

    var didTapResetCredentialsButton: (() -> Void)?

    func configure(item: Model) {

        didTapResetCredentialsButton = {
            item.services.resetCredentialsAndResetLocaleIfNecessary()
        }
        
//        if item.error is SDKError || item.error is APIError {
//
//            errorTitleLabel.text = "somethingWentWrongLabel".localized()
//            errorDetailsLabel.attributedText = attributedErrorMessageHeader(errorMessageKey: "",
//                                                                            hintsKeys: ["contentModelChangedErrorHint", "draftOrPublishedErrorHint", "localeContentErrorHint"],
//                                                                            fontSize: 14.0,
//                                                                            contentfulService: item.services.contentful)
//
//            resetCredentialsButton.setTitle("resetCredentialsLabel".localized(), for: .normal)
//            resetCredentialsButton.isHidden = false
//            return
//        } else if let error = item.error as? NoContentError {
//            errorTitleLabel.text = error.headline
//            errorDetailsLabel.attributedText = error.message
//
//            resetCredentialsButton.setTitle("resetCredentialsLabel".localized(), for: .normal)
//            resetCredentialsButton.isHidden = false
//            return
//        }
        let error = item.error as NSError
        errorTitleLabel.text = "somethingWentWrongLabel".localized()
        errorDetailsLabel.text = error.localizedDescription
        resetCredentialsButton.isHidden = true
    }

    func resetAllContent() {
        errorTitleLabel.text = nil
        errorDetailsLabel.text = nil
        resetCredentialsButton.isHidden = true
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    @IBAction func resetCredentialsButtonAction(_ sender: Any) {
        didTapResetCredentialsButton?()
    }

    @IBOutlet weak var errorTitleLabel: UILabel! {
        didSet {
            errorTitleLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        }
    }
    @IBOutlet weak var resetCredentialsButton: UIButton!
    @IBOutlet weak var errorDetailsLabel: UILabel!
}
