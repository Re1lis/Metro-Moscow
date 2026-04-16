import SwiftUI

struct ThinkingView: View {
    @State private var opacity = 0.3
    
    var body: some View {
        HStack {
            Text("Дежурный по метро думает...")
                .font(.custom("moscowsansregular", size: 14))
                .foregroundColor(.gray)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                        opacity = 1.0
                    }
                }
            Spacer()
        }
        .padding(.horizontal, 10)
    }
}
