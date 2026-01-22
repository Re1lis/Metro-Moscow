import SwiftUI
struct StatisticsView: View {
    @EnvironmentObject var counterStation: counterIsVisitedStations
    
    var totalVisited: Int {
        MetroList.flatMap { $0.stations }.filter { $0.isVisited }.count
    }
    
    var totalStations: Int {
        counterStations
    }
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Статистика посещения")
                .font(.custom("Kabel-Black", size: 30))
                .foregroundColor(.blue)
            
            HStack {
                Text("Всего станций -")
                    .font(.custom("moscowsansregular", size: 22))
                Text("\(totalStations)")
                    .font(.custom("Kabel-Black", size: 40))
                    .foregroundColor(.primary)
            }
            
            HStack {
                Text("Посещено станций -")
                    .font(.custom("moscowsansregular", size: 22))
                Text("\(totalVisited)")
                    .font(.custom("Kabel-Black", size: 40))
                    .foregroundColor(.green)
            }
            
            HStack {
                Text("Пройдено процентов -")
                    .font(.custom("moscowsansregular", size: 22))
                Text("\(Int((Double(totalVisited) / Double(totalStations)) * 100))%")
                    .font(.custom("Kabel-Black", size: 40))
                    .foregroundColor(.orange)
            }
            
            
            ScrollView {
                ForEach(MetroList) { branch in
                    VStack(spacing: 10) {
                        HStack {
                            Circle()
                                .fill(branch.color.color)
                                .frame(width: 20, height: 20)
                            Text(branch.name)
                                .font(.custom("moscowsansregular", size: 22))
                            Spacer()
                            let visited = branch.stations.filter { $0.isVisited }.count
                            Text("\(visited)/\(branch.stations.count)")
                                .font(.custom("moscowsansregular", size: 22))
                        }
                        ProgressView(value: Float(branch.stations.filter { $0.isVisited }.count), total: Float(branch.stations.count))
                            .accentColor(branch.color.color)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(15)
                }
            }
        }
        .padding(.top, 50)
        .padding()
        .ignoresSafeArea()
    }
}


#Preview{
    StatisticsView()
}
