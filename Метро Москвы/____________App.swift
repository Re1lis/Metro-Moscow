import SwiftUI

@main
struct MetroApp: App {
    @StateObject var metroManager = MetroDataManager.shared
    @StateObject var appSettings = AppSettings()
    @State private var rootId = UUID()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .id(rootId) // Привязываем ID к корневому вью
                        .environmentObject(MetroDataManager.shared)
                        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("RestartApp"))) { _ in
                            rootId = UUID()
                        }
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
