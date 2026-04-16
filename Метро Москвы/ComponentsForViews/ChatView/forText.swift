import SwiftUI
import UIKit

struct SelectableText: UIViewRepresentable {
    let content: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        textView.isSelectable = true
        
        textView.textContainer.lineBreakMode = .byWordWrapping
        
        textView.font = UIFont(name: "moscowsansregular", size: 16) ?? .systemFont(ofSize: 16)
        
        textView.setContentCompressionResistancePriority(.required, for: .vertical)
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        textView.isUserInteractionEnabled = true
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != content {
            uiView.text = content
        }
        uiView.invalidateIntrinsicContentSize()
    }
}
