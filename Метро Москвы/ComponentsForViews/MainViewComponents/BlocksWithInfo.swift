import SwiftUI

struct BlockWithInfoComponent: View {
    @EnvironmentObject private var metroManager: MetroDataManager
    
    private var totalStations: Int {
        metroManager.metroList.reduce(0) { $0 + $1.stations.count }
    }
    
    var body: some View {
        HStack(spacing: 20) {
            VStack {
                VStack {
                    Text("\(metroManager.counterIsVisited) / \(totalStations)")
                        .font(.custom("moscowsansregular", size: 25))
                        .foregroundColor(.primary)
                    Text("Посещено станций")
                        .font(.custom("moscowsansregular", size: 24))
                        .foregroundColor(.primary)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 1)
                )
            }
        }
        .padding(.trailing)
        .padding(.leading)
    }
}

#Preview {
    BlockWithInfoComponent()
        .environmentObject(MetroDataManager.shared)
}
