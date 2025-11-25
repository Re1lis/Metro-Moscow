import SwiftUI

struct StationCard: View {
    let station: Station
    let branch: MetroStruct
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var counterStation: counterIsVisitedStations

    var body: some View {
        Text("Hello, World!")
        if !station.isVisited {
            Button("Посетить"){
                withAnimation(.easeIn(duration: 1)) {
                    counterStation.addOne()
                    station.isVisited.toggle()
                }
            }
        } else {
            Button("Убрать посещение"){
                withAnimation(.easeIn(duration: 1)) {
                    counterStation.takeAwayOne()
                    station.isVisited.toggle()
                }
            }
        }
    }
}
