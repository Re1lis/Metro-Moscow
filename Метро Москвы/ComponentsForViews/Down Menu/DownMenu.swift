import SwiftUI

struct DownMenu: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            MainView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Главная")
                }
                .tag(0)
            
            StatisticsView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Статистика")
                }
                .tag(1)
            
            MainViewHistory()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Информация")
                }
                .tag(2)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Настройки")
                }
                .tag(3)
        }
    }
}
