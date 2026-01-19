import SwiftUI

struct StationCard: View {
    @ObservedObject var station: Station
    let branch: MetroStruct
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var counterStation: counterIsVisitedStations
    @EnvironmentObject var appSettings: AppSettings

    @State private var notificationMessage: String = ""
    @State private var showNotificationBanner: Bool = false

    var body: some View {
        ZStack(alignment: .top) { 
            VStack {
                HStack {
                    Text(station.name)
                        .font(.custom("Kabel-Black", size: 28))
                        .foregroundColor(.primary)
                    Spacer()
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.gray)
                    }
                }
                .padding([.top, .horizontal])

                Spacer()

                VStack(spacing: 20) {
                    Text("Информация о станции")
                        .font(.custom("Kabel-Black", size: 24))
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Год открытия: \(station.isOpeningYear)")
                        if let depth = station.depthStation {
                            Text("Глубина: \(depth) метров")
                        } else {
                            Text("Глубина: не указана")
                        }
                        Text("Ветка метро: \(branch.name)")
                    }
                    .font(.custom("moscowsansregular", size: 20))
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(15)
                }
                .padding(.horizontal)
                
                Spacer()

                Button {
                    withAnimation(.easeIn(duration: 0.3)) {
                        station.isVisited.toggle()
                        updateCounter()

                        if appSettings.notificationsEnabled {
                            let message = station.isVisited ?
                                "Вы посетили станцию \(station.name)" :
                                "Вы убрали посещение станции \(station.name)"
                            showNotification(message: message)
                        }
                    }
                } label: {
                    Text(station.isVisited ? "Убрать посещение" : "Посетить станцию")
                        .font(.custom("moscowsansregular", size: 22))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(station.isVisited ? Color.green : Color.red)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                }
            }

            if showNotificationBanner {
                Text(notificationMessage)
                    .padding()
                    .background(Color.black.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.top, 40)
                    .padding(.horizontal, 20)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func updateCounter() {
        counterStation.counterIsVisited = MetroList
            .flatMap { $0.stations }
            .filter { $0.isVisited }
            .count
    }
    
    private func showNotification(message: String) {
        notificationMessage = message
        withAnimation {
            showNotificationBanner = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                showNotificationBanner = false
            }
        }
    }
}
