import SwiftUI
struct NotificationBannerView: View {
    let message: String
    let icon: String
    let color: Color
    @Binding var isShowing: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.white)
            
            Text(message)
                .font(.custom("Kabel-Black", size: 17))
                .foregroundColor(.white)
                .lineLimit(2)
            
            Spacer()
            
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    isShowing = false
                }
            }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.white.opacity(0.8))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [color, color.opacity(0.8)]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .cornerRadius(16)
            .shadow(color: color.opacity(0.5), radius: 15, x: 0, y: 5)
        )
        .padding(.horizontal, 20)
        .padding(.top, 10)
        .transition(.move(edge: .top).combined(with: .opacity))
    }
}
