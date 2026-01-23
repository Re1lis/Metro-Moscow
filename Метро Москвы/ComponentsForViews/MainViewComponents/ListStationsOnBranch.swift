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
                LazyVStack(spacing: 16) {
                    ForEach(branch.stations) { station in
                        StationRowItem(
                            station: station,
                            branch: branch,
                            onVisitTapped: {
                                toggleStationVisit(station)
                            },
                            onDetailsTapped: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    self.isSelectedStation = station
                                }
                            }
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .padding(.top, 10)
            }
            .background(
                LinearGradient(
                    colors: [
                        Color(.systemBackground),
                        Color(.systemBackground).opacity(0.98)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
            
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
                        .font(.system(size: 22))
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
                    notificationMessage = "Станция \(station.name) отмечена как посещенная ✓"
                    notificationIcon = "checkmark.circle.fill"
                    notificationColor = .green
                } else {
                    notificationMessage = "Посещение станции \(station.name) отменено ✕"
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

struct StationRowItem: View {
    let station: Station
    let branch: MetroStruct
    let onVisitTapped: () -> Void
    let onDetailsTapped: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: station.isVisited ?
                                [branch.color.color, branch.color.color.opacity(0.7)] :
                                [Color.gray.opacity(0.1), Color.gray.opacity(0.05)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 46, height: 46)
                    .shadow(
                        color: station.isVisited ?
                            branch.color.color.opacity(0.3) :
                            Color.black.opacity(0.05),
                        radius: 3,
                        x: 0,
                        y: 2
                    )
                
                if station.isVisited {
                    Image(systemName: "checkmark")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                } else {
                    Image(systemName: "xmark")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(station.name)
                        .font(.custom("Kabel-Black", size: 20))
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    
                }
                
                if let depth = station.depthStation {
                    HStack(spacing: 8) {
                        Text("\(station.isOpeningYear)")
                            .font(.custom("moscowsansregular", size: 18))
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(
                                Capsule()
                                    .fill(Color.gray.opacity(0.1))
                            )
                        Image(systemName: "arrow.down.circle")
                            .font(.system(size: 14))
                            .foregroundColor(.blue)
                        
                        Text("\(depth) метров")
                            .font(.custom("moscowsansregular", size: 16))
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Button(action: onDetailsTapped) {
                            Image(systemName: "info.circle")
                                .font(.system(size: 18))
                                .foregroundColor(branch.color.color.opacity(0.7))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                } else {
                    HStack {
                        Spacer()
                        
                        Button(action: onDetailsTapped) {
                            Image(systemName: "info.circle")
                                .font(.system(size: 18))
                                .foregroundColor(branch.color.color.opacity(0.7))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            
            Button(action: onVisitTapped) {
                HStack(spacing: 8) {
                    Image(systemName: station.isVisited ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(station.isVisited ? .white : branch.color.color)
                    
                    Text(station.isVisited ? "Посещена" : "Посетить")
                        .font(.custom("Kabel-Black", size: 16))
                        .foregroundColor(station.isVisited ? .white : branch.color.color)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    Capsule()
                        .fill(
                            station.isVisited ?
                                LinearGradient(colors: [branch.color.color, branch.color.color.opacity(0.8)], startPoint: .top, endPoint: .bottom) :
                                LinearGradient(colors: [Color.white, Color.gray.opacity(0.1)], startPoint: .top, endPoint: .bottom)
                        )
                )
                .overlay(
                    Capsule()
                        .stroke(
                            station.isVisited ?
                                branch.color.color.opacity(0.5) :
                                branch.color.color.opacity(0.3),
                            lineWidth: 2
                        )
                )
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    station.isVisited ?
                        LinearGradient(
                            colors: [
                                branch.color.color.opacity(0.08),
                                branch.color.color.opacity(0.04)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ) :
                        LinearGradient(
                            colors: [
                                Color(.systemBackground),
                                Color(.systemBackground).opacity(0.9)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                )
                .shadow(
                    color: station.isVisited ?
                        branch.color.color.opacity(0.15) :
                        Color.black.opacity(0.08),
                    radius: station.isVisited ? 10 : 6,
                    x: 0,
                    y: station.isVisited ? 5 : 3
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(
                    station.isVisited ?
                        branch.color.color.opacity(0.3) :
                        branch.color.color.opacity(0.15),
                    lineWidth: station.isVisited ? 2 : 1
                )
        )
        .scaleEffect(station.isVisited ? 1.01 : 1)
    }
}
