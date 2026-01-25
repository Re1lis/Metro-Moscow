import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var metroManager: MetroDataManager
    @EnvironmentObject var appSettings: AppSettings
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        VStack(spacing: 20) {
                            HStack {
                                Text("Внешний вид")
                                    .font(.custom("Kabel-Black", size: 22))
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            
                            VStack(spacing: 15) {
                                SettingToggleRow(
                                    icon: "paintbrush.fill",
                                    title: "Темная тема",
                                    subtitle: "Включить темный режим",
                                    isOn: $appSettings.isDarkMode,
                                    color: .purple
                                ) {
                                    appSettings.saveSettings()
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        VStack(spacing: 20) {
                            HStack {
                                Text("Уведомления")
                                    .font(.custom("Kabel-Black", size: 22))
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            
                            VStack(spacing: 15) {
                                SettingToggleRow(
                                    icon: "bell.fill",
                                    title: "Уведомления о станциях",
                                    subtitle: "Показывать при посещении",
                                    isOn: $appSettings.notificationsEnabled,
                                    color: .red
                                ) {
                                    appSettings.saveSettings()
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        VStack(spacing: 20) {
                            HStack {
                                Text("Информация о приложении")
                                    .font(.custom("Kabel-Black", size: 22))
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            
                            VStack(spacing: 15) {
                                SettingInfoRow(
                                    icon: "info.circle.fill",
                                    title: "Версия приложения",
                                    value: "1.0.0",
                                    color: .blue
                                )
                                
                                SettingInfoRow(
                                    icon: "person.fill",
                                    title: "Разработчик",
                                    value: "AT",
                                    color: .green
                                )
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        VStack(spacing: 20) {
                            HStack {
                                Text("Данные приложения")
                                    .font(.custom("Kabel-Black", size: 22))
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            
                            VStack(spacing: 15) {
                                Button(action: {
                                    metroManager.resetAllData()
                                }) {
                                    HStack(spacing: 15) {
                                        Image(systemName: "arrow.counterclockwise.circle.fill")
                                            .font(.system(size: 22))
                                            .foregroundColor(.white)
                                            .frame(width: 45, height: 45)
                                            .background(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [Color.orange, Color.orange.opacity(0.8)]),
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                )
                                            )
                                            .cornerRadius(12)
                                            .shadow(color: Color.orange.opacity(0.3), radius: 5, x: 0, y: 3)
                                        
                                        VStack(alignment: .leading, spacing: 3) {
                                            Text("Сбросить все посещения")
                                                .font(.custom("Kabel-Black", size: 18))
                                                .foregroundColor(.primary)
                                            
                                            Text("Начать отслеживание заново")
                                                .font(.custom("moscowsansregular", size: 14))
                                                .foregroundColor(.secondary)
                                        }
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 12)
                                    .background(Color(.systemBackground))
                                    .cornerRadius(18)
                                    .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 3)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                HStack(spacing: 15) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.system(size: 22))
                                        .foregroundColor(.white)
                                        .frame(width: 45, height: 45)
                                        .background(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color.green, Color.green.opacity(0.8)]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .cornerRadius(12)
                                        .shadow(color: Color.green.opacity(0.3), radius: 5, x: 0, y: 3)
                                    
                                    VStack(alignment: .leading, spacing: 3) {
                                        Text("Посещено станций")
                                            .font(.custom("Kabel-Black", size: 18))
                                            .foregroundColor(.primary)
                                        
                                        Text("\(metroManager.counterIsVisited)/\(metroManager.metroList.reduce(0) { $0 + $1.stations.count })")
                                            .font(.custom("moscowsansregular", size: 14))
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 15)
                                .padding(.vertical, 12)
                                .background(Color(.systemBackground))
                                .cornerRadius(18)
                                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 3)
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        VStack(spacing: 15) {
                            Text("Метро Москвы")
                                .font(.custom("Kabel-Black", size: 18))
                                .foregroundColor(.secondary)
                            
                            Text("Отслеживайте свои поездки\nи открывайте историю метро")
                                .font(.custom("moscowsansregular", size: 16))
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .lineSpacing(4)
                        }
                        .padding(.top, 20)
                        
                        Spacer()
                            .frame(height: 30)
                    }
                    .padding(.vertical, 25)
                }
            }
            .navigationTitle("Настройки")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Настройки")
                        .font(.custom("Kabel-Black", size: 28))
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct SettingToggleRow: View {
    let icon: String
    let title: String
    let subtitle: String
    @Binding var isOn: Bool
    let color: Color
    let onSave: (() -> Void)?
    
    init(icon: String, title: String, subtitle: String, isOn: Binding<Bool>, color: Color, onSave: (() -> Void)? = nil) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self._isOn = isOn
        self.color = color
        self.onSave = onSave
    }
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 22))
                .foregroundColor(.white)
                .frame(width: 45, height: 45)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [color, color.opacity(0.8)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(12)
                .shadow(color: color.opacity(0.3), radius: 5, x: 0, y: 3)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.custom("Kabel-Black", size: 18))
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .font(.custom("moscowsansregular", size: 14))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(color)
                .scaleEffect(0.9)
                .onChange(of: isOn) { _ in
                    let impact = UIImpactFeedbackGenerator(style: .light)
                    impact.impactOccurred()
                    
                    onSave?()
                }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
        .cornerRadius(18)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 3)
    }
}

struct SettingInfoRow: View {
    let icon: String
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 22))
                .foregroundColor(.white)
                .frame(width: 45, height: 45)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [color, color.opacity(0.8)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(12)
                .shadow(color: color.opacity(0.3), radius: 5, x: 0, y: 3)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.custom("Kabel-Black", size: 18))
                    .foregroundColor(.primary)
            }
            
            Spacer()
            
            Text(value)
                .font(.custom("moscowsansregular", size: 16))
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
        .cornerRadius(18)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 3)
    }
}

#Preview {
    SettingsView()
        .environmentObject(MetroDataManager.shared)
        .environmentObject(AppSettings())
}
