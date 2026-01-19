

import SwiftUI

@main
struct MetroApp: App {
    @StateObject var counter = counterIsVisitedStations()
    @StateObject var appSettings = AppSettings()

    var body: some Scene {
        WindowGroup {
            DownMenu()
                .environmentObject(counter)
                .environmentObject(appSettings)
                .preferredColorScheme(appSettings.isDarkMode ? .dark : .light)
        }
    }
}
