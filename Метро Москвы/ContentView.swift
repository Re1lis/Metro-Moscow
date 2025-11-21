import SwiftUI

struct ContentView: View {
    @State private var isSkippingStartedView: Bool = false
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                if !isSkippingStartedView {
                    StartedView()
                } else {
                    
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(.easeIn(duration: 0.2)){
                        isSkippingStartedView.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
