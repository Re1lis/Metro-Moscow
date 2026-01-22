import SwiftUI


struct NotificationBannerView: View {
    let message: String
    let icon: String
    let color: Color
    @Binding var isShowing: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 22))
                .foregroundColor(.white)
            
            Text(message)
                .font(.custom("moscowsansregular", size: 16))
                .foregroundColor(.white)
                .lineLimit(2)
                .minimumScaleFactor(0.9)
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    isShowing = false
                }
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white.opacity(0.8))
                    .padding(6)
                    .background(Circle().fill(Color.white.opacity(0.2)))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [color, color.opacity(0.9)]),
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .cornerRadius(16)
        .shadow(color: color.opacity(0.4), radius: 15, x: 0, y: 5)
        .padding(.horizontal, 20)
        .padding(.top, 10)
        .transition(
            .asymmetric(
                insertion: .move(edge: .top).combined(with: .opacity),
                removal: .move(edge: .top).combined(with: .opacity)
            )
        )
    }
}
