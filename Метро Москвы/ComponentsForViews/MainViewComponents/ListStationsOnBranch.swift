import SwiftUI

struct ListStationsOnBranch: View {
    @State var isSelectedStation: Station? = nil
    @State private var showBranchInfo = false
    let branch: MetroStruct
    @EnvironmentObject var counterStation: counterIsVisitedStations
    @EnvironmentObject var appSettings: AppSettings
    
    @State private var notificationMessage: String = ""
    @State private var showNotificationBanner: Bool = false
    @State private var notificationIcon: String = ""
    @State private var notificationColor: Color = .green
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(branch.stations) { station in
                        HStack(spacing: 16) {
//                            ZStack {
//                                Circle()
//                                    .fill(
//                                        LinearGradient(
//                                            colors: station.isVisited ?
//                                                [branch.color.color, branch.color.color.opacity(0.7)] :
//                                                [Color.white.opacity(0.1), Color.gray.opacity(0.05)],
//                                            startPoint: .topLeading,
//                                            endPoint: .bottomTrailing
//                                        )
//                                    )
//                                    .frame(width: 44, height: 44)
//                                    .shadow(
//                                        color: station.isVisited ?
//                                            branch.color.color.opacity(0.5) :
//                                            Color.black.opacity(0.1),
//                                        radius: station.isVisited ? 8 : 3,
//                                        x: 0,
//                                        y: 2
//                                    )
//                                    .overlay(
//                                        Circle()
//                                            .stroke(
//                                                station.isVisited ?
//                                                    branch.color.color.opacity(0.6) :
//                                                    branch.color.color.opacity(0.3),
//                                                lineWidth: 2
//                                            )
//                                    )
//                                
//                                Text("\(Array(branch.stations).firstIndex(where: { $0.id == station.id }) ?? 0 + 1)")
//                                    .font(.custom("Kabel-Black", size: 20))
//                                    .foregroundColor(station.isVisited ? .white : branch.color.color)
//                            }
                            
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    self.isSelectedStation = station
                                }
                            } label: {
                                Text(station.name)
                                    .font(.custom("Kabel-Black", size: 24))
                                    .foregroundColor(.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    self.isSelectedStation = station
                                }
                            } label: {
                                Image(systemName: "info.circle.fill")
                                    .font(.system(size: 22))
                                    .foregroundColor(branch.color.color)
                                    .shadow(color: branch.color.color.opacity(0.2), radius: 2, x: 0, y: 1)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Button {
                                toggleStationVisit(station)
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                colors: station.isVisited ?
                                                    [branch.color.color.opacity(0.3), branch.color.color.opacity(0.1)] :
                                                    [branch.color.color, branch.color.color.opacity(0.7)],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .frame(width: 44, height: 44)
                                        .shadow(
                                            color: station.isVisited ?
                                                branch.color.color.opacity(0.3) :
                                                branch.color.color.opacity(0.4),
                                            radius: station.isVisited ? 4 : 6,
                                            x: 0,
                                            y: 2
                                        )
                                    
                                    Image(systemName: station.isVisited ? "mappin.circle.fill" : "mappin.circle")
                                        .font(.system(size: 20))
                                        .foregroundColor(station.isVisited ? branch.color.color : .white)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 18)
                        .background(
                            RoundedRectangle(cornerRadius: 18)
                                .fill(
                                    station.isVisited ?
                                        branch.color.color.opacity(0.15) :
                                        Color(.systemBackground)
                                )
                                .shadow(
                                    color: station.isVisited ?
                                        branch.color.color.opacity(0.2) :
                                        Color.black.opacity(0.05),
                                    radius: station.isVisited ? 8 : 3,
                                    x: 0,
                                    y: station.isVisited ? 4 : 1
                                )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(
                                    station.isVisited ?
                                        branch.color.color.opacity(0.4) :
                                        branch.color.color.opacity(0.2),
                                    lineWidth: station.isVisited ? 2 : 1.5
                                )
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
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
        .sheet(item: $isSelectedStation) { station in
            StationCard(station: station, branch: branch)
        }
        .sheet(isPresented: $showBranchInfo) {
            BranchInfoView(branch: branch)
        }
        .navigationTitle(branch.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showBranchInfo.toggle() }) {
                    Image(systemName: "info.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(branch.color.color)
                }
            }
        }
    }
    
    private func toggleStationVisit(_ station: Station) {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            station.isVisited.toggle()
            
            if station.isVisited {
                counterStation.counterIsVisited += 1
            } else {
                counterStation.counterIsVisited -= 1
            }
            
            if appSettings.notificationsEnabled {
                if station.isVisited {
                    notificationMessage = "Станция \(station.name) отмечена как посещенная"
                    notificationIcon = "mappin.circle.fill"
                    notificationColor = branch.color.color
                } else {
                    notificationMessage = "Посещение станции \(station.name) отменено"
                    notificationIcon = "xmark.circle.fill"
                    notificationColor = .orange
                }
                showNotification()
            }
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
