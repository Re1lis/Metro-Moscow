import SwiftUI

struct StationCard: View {
    @ObservedObject var station: Station
    let branch: MetroStruct
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var counterStation: CounterIsVisitedStations
    @EnvironmentObject var appSettings: AppSettings

    @State private var notificationMessage: String = ""
    @State private var showNotificationBanner: Bool = false
    @State private var notificationIcon: String = ""
    @State private var notificationColor: Color = .green

    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                HStack {
                    Text(station.name)
                        .font(.custom("Kabel-Black", size: 32))
                        .foregroundColor(.primary)
                        .padding(.leading, 24)
                    
                    Spacer()
                    
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.gray.opacity(0.7))
                            .background(Circle().fill(Color(.systemBackground)).opacity(0.9))
                    }
                    .padding(.trailing, 24)
                }
                .padding(.top, 20)
                .padding(.bottom, 10)

                Spacer()
                
                VStack(spacing: 24) {
                    Text("Информация о станции")
                        .font(.custom("Kabel-Black", size: 28))
                        .foregroundColor(branch.color.color)
                        .padding(.top, 8)
                    
                    VStack(spacing: 16) {
                        HStack(spacing: 15) {
                            Image(systemName: "calendar.badge.clock")
                                .font(.system(size: 22))
                                .foregroundColor(.blue)
                                .frame(width: 40)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Год открытия")
                                    .font(.custom("moscowsansregular", size: 16))
                                    .foregroundColor(.secondary)
                                Text("\(station.isOpeningYear)")
                                    .font(.custom("Kabel-Black", size: 22))
                                    .foregroundColor(.primary)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.blue.opacity(0.08))
                        .cornerRadius(12)
                        
                        HStack(spacing: 15) {
                            Image(systemName: "arrow.down.circle")
                                .font(.system(size: 22))
                                .foregroundColor(station.depthStation != nil ? .green : .gray)
                                .frame(width: 40)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Глубина станции")
                                    .font(.custom("moscowsansregular", size: 16))
                                    .foregroundColor(.secondary)
                                
                                if let depth = station.depthStation {
                                    Text("\(depth) метров")
                                        .font(.custom("Kabel-Black", size: 22))
                                        .foregroundColor(.green)
                                } else {
                                    Text("Не указана")
                                        .font(.custom("moscowsansregular", size: 18))
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.green.opacity(0.08))
                        .cornerRadius(12)
                        
                        HStack(spacing: 15) {
                            Circle()
                                .fill(branch.color.color)
                                .frame(width: 32, height: 32)
                                .overlay(
                                    Text(branch.number)
                                        .font(.custom("Kabel-Black", size: 16))
                                        .foregroundColor(.white)
                                )
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Ветка метро")
                                    .font(.custom("moscowsansregular", size: 16))
                                    .foregroundColor(.secondary)
                                Text(branch.name)
                                    .font(.custom("Kabel-Black", size: 20))
                                    .foregroundColor(.primary)
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.9)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.gray.opacity(0.08))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 20)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.systemBackground))
                        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
                )
                .padding(.horizontal)
                
                Spacer()

                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            let wasVisited = station.isVisited
                            station.isVisited.toggle()
                            updateCounter()

                            if appSettings.notificationsEnabled {
                                if wasVisited == false {
                                    notificationMessage = "Станция \(station.name) отмечена как посещенная"
                                    notificationIcon = "checkmark.circle.fill"
                                    notificationColor = .green
                                } else {
                                    notificationMessage = "Посещение станции \(station.name) отменено"
                                    notificationIcon = "xmark.circle.fill"
                                    notificationColor = .orange
                                }
                                showNotification()
                            }
                        }
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: station.isVisited ? "checkmark.circle.fill" : "mappin.circle.fill")
                            .font(.system(size: 22))
                        
                        Text(station.isVisited ? "Убрать посещение" : "Посетить станцию")
                            .font(.custom("Kabel-Black", size: 22))
                    }
                    .foregroundColor(.white)
                    .padding(.vertical, 18)
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                station.isVisited ? Color.green : Color.blue,
                                station.isVisited ? Color.green.opacity(0.8) : Color.blue.opacity(0.8)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(16)
                    .shadow(color: station.isVisited ? .green.opacity(0.3) : .blue.opacity(0.3), radius: 8, x: 0, y: 4)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 30)
                }
            }
            .background(Color(.systemBackground).ignoresSafeArea())

            if showNotificationBanner {
                NotificationBannerView(
                    message: notificationMessage,
                    icon: notificationIcon,
                    color: notificationColor,
                    isShowing: $showNotificationBanner
                )
                .zIndex(1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func updateCounter() {
        if station.isVisited {
            counterStation.counterIsVisited += 1
        } else {
            counterStation.counterIsVisited -= 1
        }
    }
    
    private func showNotification() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
            showNotificationBanner = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(.easeOut(duration: 0.3)) {
                showNotificationBanner = false
            }
        }
    }
}
