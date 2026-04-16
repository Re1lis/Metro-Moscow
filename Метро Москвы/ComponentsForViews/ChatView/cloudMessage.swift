import SwiftUI
import UIKit

struct ChatBubble: View {
    let message: AIChatMessage
    var isUser: Bool { message.role == "user" }
    
    var body: some View {
        HStack {
            if isUser { Spacer() }
            Text(message.content)
                .font(.custom("moscowsansregular", size: 16))
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .foregroundColor(isUser ? .white : .primary)
                .background(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 18,
                        bottomLeadingRadius: isUser ? 18 : 2,
                        bottomTrailingRadius: isUser ? 2 : 18,
                        topTrailingRadius: 18
                    )
                    .fill(isUser ? Color.red : Color(.secondarySystemBackground))
                )
                .frame(maxWidth: UIScreen.main.bounds.width * 0.75, alignment: isUser ? .trailing : .leading)
            if !isUser { Spacer() }
        }
        .padding(.horizontal, 10)
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
