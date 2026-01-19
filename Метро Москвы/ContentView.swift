import SwiftUI

struct ContentView: View {
    @State private var isSkippingStartedView: Bool = false
    @StateObject private var count = counterIsVisitedStations()

    var body: some View {
        ZStack {
            MainView()
                .environmentObject(count)
                .opacity(isSkippingStartedView ? 1 : 0)

            // Стартовый экран
            if !isSkippingStartedView {
                StartedView()
                    .transition(.opacity)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isSkippingStartedView = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
