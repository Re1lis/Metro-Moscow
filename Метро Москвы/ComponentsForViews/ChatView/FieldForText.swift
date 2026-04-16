import SwiftUI

struct ChatInputArea: View {
    @Binding var text: String
    var isFocused: FocusState<Bool>.Binding
    var isBlocked: Bool
    var onSend: () -> Void
    
    var body: some View {
        HStack {
            TextField("Спросить...", text: $text)
                .disabled(isBlocked)
                .opacity(isBlocked ? 0.5 : 1.0)
            
            Button(action: onSend) {
                Image(systemName: "arrow.up.circle.fill")
                    .foregroundColor(isBlocked ? .gray : .red)
            }
            .disabled(isBlocked || text.isEmpty)
        }
        .padding()
    }
}
