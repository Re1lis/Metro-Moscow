import SwiftUI



struct SettingsView: View {
    @State private var notificationsEnabled: Bool = true
    @State private var darkModeEnabled: Bool = false
    @EnvironmentObject var counterStation: counterIsVisitedStations
    @EnvironmentObject var appSettings: AppSettings
    


    var body: some View {
            NavigationStack {
                Form {
                    Section(header: Text("Внешний вид")) {
                        Toggle("Темная тема", isOn: $appSettings.isDarkMode)
                            .tint(.red)
                    }

                    Section(header: Text("Уведомления")) {
                        Toggle(
                            "Показывать уведомления о посещении станции",
                            isOn: $appSettings.notificationsEnabled
                        )
                        .tint(.red)
                    }

                    Section(header: Text("Информация")) {
                        HStack {
                            Text("Версия приложения")
                            Spacer()
                            Text("1.0.0")
                                .foregroundColor(.gray)
                        }
                        Text("Разработчик: AT")
                            .foregroundColor(.gray)
                    }
                }
                .navigationTitle("Настройки")
            }
        }
    }

#Preview {
    SettingsView()
        .environmentObject(AppSettings())
}
