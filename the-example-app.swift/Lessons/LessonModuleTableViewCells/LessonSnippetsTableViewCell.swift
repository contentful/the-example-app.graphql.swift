
import Foundation
import UIKit
import markymark

enum SupportedLanguages: CaseIterable {
    case swift, java, dotNet, curl, python, ruby, javascript, php, javaAndroid

    var fragmentKeyPath: KeyPath<LessonCodeSnippetFragment, String?> {
        switch self {
        case .swift: return \LessonCodeSnippetFragment.swift
        case .javaAndroid: return \LessonCodeSnippetFragment.javaAndroid
        case .java: return \LessonCodeSnippetFragment.java
        case .javascript: return \LessonCodeSnippetFragment.javascript
        case .dotNet: return \LessonCodeSnippetFragment.dotNet
        case .ruby: return \LessonCodeSnippetFragment.ruby
        case .python: return \LessonCodeSnippetFragment.python
        case .php: return \LessonCodeSnippetFragment.php
        case .curl: return \LessonCodeSnippetFragment.curl
        }
    }

    func displayName() -> String {
        switch self {
        case .swift:        return "Swift"
        case .java:         return "Java"
        case .javaAndroid:  return "Android"
        case .curl:         return "cURL"
        case .dotNet:       return ".NET"
        case .javascript:   return "JavaScript"
        case .php:          return "PHP"
        case .ruby:         return "Ruby"
        case .python:       return "Python"
        }
    }
}

// TODO: Enum with keypaths oder?
class LessonSnippetsTableViewCell: UITableViewCell, CellConfigurable, UIPickerViewDataSource, UIPickerViewDelegate {

    static let pickerOptions: [SupportedLanguages] = SupportedLanguages.allCases

    var snippets: LessonCodeSnippetFragment?

    func configure(item: LessonCodeSnippetFragment) {
        self.snippets = item
        guard let code = item.swift else { return }
        populateCodeSnippet(code: code)
        programmingLanguageTextField.text = SupportedLanguages.swift.displayName() + " ▼" // Swift treats unicode characters as one character :-)
    }

    func resetAllContent() {
        snippets = nil
        codeSnippetLabel.text = ""
    }

    func populateCodeSnippet(code: String) {
        let snippet = """
        ```
        \(code)

        ```
        """
        let attributedText = Markdown.attributedText(text: snippet)
        codeSnippetLabel.attributedText = attributedText
    }

    @objc func cancelPickingCodeLanguageAction(_ sender: UIBarButtonItem) {
        programmingLanguageTextField.endEditing(true)
    }

    @objc func donePickingCodeLanguageAction(_ sender: UIBarButtonItem) {
        if let picker = programmingLanguageTextField.inputView as? UIPickerView {
            let selectedRow = picker.selectedRow(inComponent: 0)
            let selectedLanguage = LessonSnippetsTableViewCell.pickerOptions[selectedRow]
            programmingLanguageTextField.text = LessonSnippetsTableViewCell.pickerOptions[selectedRow].displayName() + " ▼"
            programmingLanguageTextField.endEditing(true)

            guard let code = snippets?[keyPath: selectedLanguage.fragmentKeyPath] else { return }
            populateCodeSnippet(code: code)
        }
    }

    @IBOutlet weak var codeSnippetLabel: UILabel!
    
    @IBOutlet weak var programmingLanguageTextField: UITextField! {
        didSet {
            programmingLanguageTextField.textColor = .blue
            programmingLanguageTextField.tintColor = .clear

            let pickerView = UIPickerView()

            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.showsSelectionIndicator = true
            pickerView.translatesAutoresizingMaskIntoConstraints = false
            programmingLanguageTextField.inputView = pickerView
            programmingLanguageTextField.borderStyle = .none

            let toolbar = UIToolbar()
            let cancelButton = UIBarButtonItem(title: NSLocalizedString("Cancel", comment: ""), style: .plain, target: self, action: #selector(LessonSnippetsTableViewCell.cancelPickingCodeLanguageAction(_:)))
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(title: NSLocalizedString("Done", comment: ""), style: .done, target: self, action: #selector(LessonSnippetsTableViewCell.donePickingCodeLanguageAction(_:)))
            toolbar.items = [cancelButton, flexibleSpace, doneButton]

            toolbar.sizeToFit()

            programmingLanguageTextField.inputAccessoryView = toolbar
        }
    }

    @IBOutlet weak var languageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    // MARK: UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return LessonSnippetsTableViewCell.pickerOptions.count
    }


    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "TODO"
        // TODO:
//        return LessonSnippetsTableViewCell.pickerOptions[row].displayName()
    }
}

class CodingLanguageTextField: UITextField {

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if isFirstResponder {
            DispatchQueue.main.async {
                (sender as? UIMenuController)?.setMenuVisible(false, animated: false)
            }
            return false
        }

        return super.canPerformAction(action, withSender: sender)
    }

    override func addGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer is UILongPressGestureRecognizer {
            gestureRecognizer.isEnabled = false
        }
        super.addGestureRecognizer(gestureRecognizer)
        return
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textColor = .darkGray
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        textColor = .lightGray
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        textColor = .lightGray
    }
}
