import SwiftUI

@main
struct MetroApp: App {
    @StateObject var metroManager = MetroDataManager.shared
    @StateObject var appSettings = AppSettings()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(metroManager)
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
