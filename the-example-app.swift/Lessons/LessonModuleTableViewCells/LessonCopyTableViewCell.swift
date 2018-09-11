
import Foundation
import UIKit
import markymark

class LessonCopyTableViewCell: UITableViewCell, CellConfigurable, UITextViewDelegate {

    typealias ItemType = LessonCopyFragment

    func configure(item: LessonCopyFragment) {
        guard let copy = item.copy else { return }
        let attributedText = Markdown.attributedText(text: copy)
        copyTextView.attributedText = attributedText
        copyTextView.sizeToFit()
    }

    func resetAllContent() {
        copyTextView.text = ""
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    @IBOutlet weak var copyTextView: UITextView! {
        didSet {
            copyTextView.delegate = self
        }
    }

    // MARK: UITextViewDelegate

    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return false
    }

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL, options: [:], completionHandler: nil)
        return false
    }
}
