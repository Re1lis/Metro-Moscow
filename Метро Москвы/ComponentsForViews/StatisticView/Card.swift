import SwiftUI

struct StatisticCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    let delay: Double
    
    @State private var isVisible = false
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 32))
                .foregroundColor(color)
                .symbolEffect(.bounce, value: isVisible)
            
            Text(value)
                .font(.custom("Kabel-Black", size: 36))
                .foregroundColor(.primary)
                .contentTransition(.numericText())
            
            Text(title)
                .font(.custom("moscowsansregular", size: 14))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: color.opacity(0.2), radius: 8, y: 4)
        )
        .opacity(isVisible ? 1 : 0)
        .scaleEffect(isVisible ? 1 : 0.8)
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(delay)) {
                isVisible = true
            }
        }
    }
}

