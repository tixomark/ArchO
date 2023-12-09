//
//  TextFieldView.swift
//  ArchO
//
//  Created by Tixon Markin on 12.10.2023.
//

import UIKit

protocol TextViewDelegate: AnyObject {
    func textDidChangeIn(_ textView: TextView, text: String)
    func textDidEndEditingIn(_ textView: TextView)
}

class TextView: UIView, ItemIdentifiable {
    var textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.autocapitalizationType = .none
        textView.isScrollEnabled = false
        textView.textColor = .archoSecondaryColor
        textView.backgroundColor = .archoBackgroundColor
        return textView
    }()
    var placeholder: String?
    private var isShowingPlaceholder = true
    
    var itemID: ItemID!
    
    weak var delegate: TextViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpConstraints()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: TextView.noIntrinsicMetric, height: 56)
    }
    
    private func setUpUI() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.archoSecondaryColor.cgColor
        self.layer.borderWidth = 1.5
        
        textView.delegate = self
        self.addSubview(textView)
    }
    
    private func setUpConstraints() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            textView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)])
    }
    
    func configure(placeholder: String? = nil, text: String? = nil) {
        self.placeholder = placeholder
        
        if text != nil {
            textView.text = text
            isShowingPlaceholder = false
        } else if placeholder != nil {
            showPlaceholder()
        }
    }
    
    private func showPlaceholder() {
        textView.text = placeholder
        textView.textColor = .archoLightGray
        isShowingPlaceholder = true
        textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
    }
}

extension TextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if !isShowingPlaceholder {
            delegate?.textDidChangeIn(self, text: textView.text)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let updatedText = (textView.text! as NSString).replacingCharacters(in: range, with: text)
        
        if updatedText.isEmpty {
            showPlaceholder()
            delegate?.textDidChangeIn(self, text: "")
        } else if isShowingPlaceholder && !text.isEmpty {
            isShowingPlaceholder = false
            textView.textColor = UIColor.black
            textView.text = text
            delegate?.textDidChangeIn(self, text: text)
        } else {
            return true
        }
        return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if isShowingPlaceholder {
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument , to: textView.beginningOfDocument)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        delegate?.textDidEndEditingIn(self)
    }

}
