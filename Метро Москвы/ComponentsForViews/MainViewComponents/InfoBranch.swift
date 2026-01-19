import SwiftUI

struct BranchInfoView: View {
    @Environment(\.dismiss) var dismiss
    let branch: MetroStruct
    
    var body: some View {
        VStack(spacing: 30) {
            
            HStack {
                Spacer()
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            Spacer()
            
            VStack(spacing: 20) {
                Text("Информация о ветке")
                    .font(.custom("Kabel-Black", size: 28))
                    .foregroundColor(branch.color.color)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Название ветки: \(branch.name)")
                    Text("Длина ветки: \(branch.lenghtBranch) км")
                    Text("Время в пути: \(branch.fullTravelTime)")
                    Text("Количество станций: \(branch.stations.count)")
                    
                    let visited = branch.stations.filter { $0.isVisited }.count
                    Text("Посещено станций: \(visited)/\(branch.stations.count)")
                    
                    ProgressView(value: Double(visited), total: Double(branch.stations.count))
                        .accentColor(branch.color.color)
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                }
                .font(.custom("moscowsansregular", size: 20))
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)
            }
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

