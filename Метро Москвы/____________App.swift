import SwiftUI

@main
struct MetroApp: App {
    @StateObject var counter = counterIsVisitedStations()
    @StateObject var appSettings = AppSettings()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(counter)
                .environmentObject(appSettings)
                .onChange(of: appSettings.isDarkMode) { value in
                    UIApplication.shared
                        .connectedScenes
                        .compactMap { $0 as? UIWindowScene }
                        .first?
                        .windows
                        .first?
                        .overrideUserInterfaceStyle = value ? .dark : .light
                }
        }
    }
}
