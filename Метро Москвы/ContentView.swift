import SwiftUI

struct ContentView: View {
    @State private var showStartedView = true
    @StateObject private var count = CounterIsVisitedStations()
    @StateObject var counter = CounterIsVisitedStations()
    @StateObject var appSettings = AppSettings()
    
    var body: some View {
        ZStack {
            if !showStartedView {
                MainView()
                    .environmentObject(count)
                    .transition(.opacity)
                DownMenu()
                    .environmentObject(counter)
                    .environmentObject(appSettings)
                    .preferredColorScheme(appSettings.isDarkMode ? .dark : .light)
            }
            
            if showStartedView {
                StartedView()
                    .transition(.opacity)
            }
            
            
        }
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5 ) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showStartedView = false
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
