import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var counterStation: counterIsVisitedStations
    
    var totalVisited: Int {
        MetroList.flatMap { $0.stations }.filter { $0.isVisited }.count
    }
    
    var totalStations: Int {
        counterStations
    }
    
    var percentage: Int {
        guard totalStations > 0 else { return 0 }
        return Int((Double(totalVisited) / Double(totalStations)) * 100)
    }
    
    @State private var isAppeared = false
    @State private var animatedPercentage = 0
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 20) {
                        StatisticCard(
                            title: "Всего станций",
                            value: "\(totalStations)",
                            icon: "number.circle.fill",
                            color: .blue,
                            delay: 0.1
                        )
                        
                        StatisticCard(
                            title: "Посещено",
                            value: "\(totalVisited)",
                            icon: "checkmark.circle.fill",
                            color: .green,
                            delay: 0.2
                        )
                        
                        StatisticCard(
                            title: "Прогресс",
                            value: "\(animatedPercentage)%",
                            icon: "chart.pie.fill",
                            color: .orange,
                            delay: 0.3
                        )
                        
                        StatisticCard(
                            title: "Осталось",
                            value: "\(max(0, totalStations - totalVisited))",
                            icon: "flag.circle.fill",
                            color: .red,
                            delay: 0.4
                        )
                    }
                    .padding(.horizontal)
                    .opacity(isAppeared ? 1 : 0)
                    .offset(y: isAppeared ? 0 : 20)
                    .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.1), value: isAppeared)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Image(systemName: "map.fill")
                                .foregroundColor(.blue)
                                .font(.title3)
                            
                            Text("Прогресс по веткам")
                                .font(.custom("moscowsansregular", size: 22))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text("\(totalVisited)/\(totalStations)")
                                .font(.custom("Kabel-Black", size: 20))
                                .foregroundColor(.secondary)
                        }
                        .padding(.horizontal)
                        
                        ForEach(Array(MetroList.enumerated()), id: \.element.id) { index, branch in
                            let visited = branch.stations.filter { $0.isVisited }.count
                            let total = branch.stations.count
                            let progress = Float(visited) / Float(total)
                            
                            BranchProgressCard(
                                branch: branch,
                                visited: visited,
                                total: total,
                                progress: progress,
                                delay: Double(index) * 0.1 + 0.3
                            )
                            .opacity(isAppeared ? 1 : 0)
                            .offset(y: isAppeared ? 0 : 20)
                            .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(Double(index) * 0.1 + 0.3), value: isAppeared)
                        }
                    }
                }
                .padding(.vertical, 20)
            }
            .background(
                LinearGradient(
                    colors: [Color(.systemGray6), Color(.systemBackground)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
            .onAppear {
                isAppeared = true
                
                withAnimation(.easeOut(duration: 1.5)) {
                    animatedPercentage = percentage
                }
            }
            .onChange(of: percentage) { oldValue, newValue in
                withAnimation(.easeOut(duration: 0.8)) {
                    animatedPercentage = newValue
                }
                
                if newValue > oldValue && newValue % 25 == 0 {
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Статистика посещений")
                        .font(.custom("Kabel-Black", size: 28))
                        .foregroundColor(.red)
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    StatisticsView()
        .environmentObject(counterIsVisitedStations())
}
