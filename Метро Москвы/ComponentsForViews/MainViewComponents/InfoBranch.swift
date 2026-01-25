import SwiftUI

struct BranchInfoView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var metroManager: MetroDataManager
    let branch: MetroStruct
    
    var visitedCount: Int {
        branch.stations.filter { $0.isVisited }.count
    }
    
    var progress: Double {
        guard branch.stations.count > 0 else { return 0 }
        return Double(visitedCount) / Double(branch.stations.count)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(.gray.opacity(0.7))
                        .background(Circle().fill(Color(.systemBackground)).opacity(0.9))
                }
                .padding(.top, 16)
                .padding(.trailing, 20)
            }
            .frame(height: 50)
            
            ScrollView {
                VStack(spacing: 30) {
                    VStack(spacing: 20) {
                        ZStack {
                            Circle()
                                .fill(branch.color.color)
                                .frame(width: 80, height: 80)
                                .shadow(color: branch.color.color.opacity(0.3), radius: 10, x: 0, y: 5)
                            
                            Text(branch.number)
                                .font(.custom("Kabel-Black", size: 32))
                                .foregroundColor(.white)
                        }
                        
                        Text(branch.name)
                            .font(.custom("Kabel-Black", size: 32))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.top, 20)
                    
                    VStack(spacing: 16) {
                        BranchInfoCard(
                            icon: "point.bottomleft.forward.to.point.topright.scurvepath.fill",
                            title: "Длина ветки",
                            value: "\(branch.lenghtBranch) км",
                            color: .blue
                        )
                        
                        BranchInfoCard(
                            icon: "clock.fill",
                            title: "Время в пути",
                            value: branch.fullTravelTime,
                            color: .orange
                        )
                        
                        BranchInfoCard(
                            icon: "mappin.circle.fill",
                            title: "Количество станций",
                            value: "\(branch.stations.count)",
                            color: .purple
                        )
                        
                        BranchInfoCard(
                            icon: "checkmark.circle.fill",
                            title: "Посещено станций",
                            value: "\(visitedCount)/\(branch.stations.count)",
                            color: .green
                        )
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 15) {
                        HStack {
                            Text("Прогресс посещения")
                                .font(.custom("moscowsansregular", size: 18))
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            Text("\(Int(progress * 100))%")
                                .font(.custom("Kabel-Black", size: 22))
                                .foregroundColor(branch.color.color)
                        }
                        .padding(.horizontal, 24)
                        
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 12)
                            
                            Capsule()
                                .fill(branch.color.color)
                                .frame(width: CGFloat(progress) * (UIScreen.main.bounds.width - 80), height: 12)
                                .animation(.spring(response: 0.6, dampingFraction: 0.8), value: progress)
                            
                            if visitedCount > 0 {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 16, height: 16)
                                    .shadow(radius: 2)
                                    .offset(x: CGFloat(progress) * (UIScreen.main.bounds.width - 80) - 8, y: 0)
                            }
                        }
                        .padding(.horizontal, 24)
                        .frame(height: 20)
                    }
                    .padding(.vertical, 20)
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
                    if visitedCount == 0 && branch.stations.count > 0 {
                        VStack(spacing: 12) {
                            Image(systemName: "map.fill")
                                .font(.system(size: 40))
                                .foregroundColor(branch.color.color.opacity(0.7))
                            
                            Text("Начните исследовать эту ветку!")
                                .font(.custom("moscowsansregular", size: 18))
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(branch.color.color.opacity(0.1))
                        .cornerRadius(16)
                        .padding(.horizontal)
                    }
                    
                    if visitedCount == branch.stations.count && branch.stations.count > 0 {
                        VStack(spacing: 12) {
                            Image(systemName: "trophy.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.yellow)
                            
                            Text("Поздравляем! Вы посетили все станции этой ветки!")
                                .font(.custom("moscowsansregular", size: 18))
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.yellow.opacity(0.1))
                        .cornerRadius(16)
                        .padding(.horizontal)
                    }
                    
                    NavigationLink(destination: ListStationsOnBranch(branch: branch)) {
                        HStack {
                            Image(systemName: "list.bullet")
                                .foregroundColor(branch.color.color)
                            Text("Список всех станций")
                                .font(.custom("moscowsansregular", size: 18))
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 40)
            }
        }
        .background(Color(.systemBackground).ignoresSafeArea())
    }
}
