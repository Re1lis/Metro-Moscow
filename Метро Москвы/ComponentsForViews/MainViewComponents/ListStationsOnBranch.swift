import SwiftUI

struct ListStationsOnBranch: View {
    @State var isSelectedStation: Station? = nil
    let branch: MetroStruct
    var body: some View {
        VStack {
            ForEach(branch.stations) { station in
                Button {
                    withAnimation(.easeIn(duration: 2)){
                        self.isSelectedStation = station
                    }
                } label : {
                    Text(station.name)
                    if station.isVisited {
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.green)
                    } else {
                        Image(systemName:"xmark.circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.red)
                    }
                }
            }
            
        }
        .ignoresSafeArea()
        .sheet(item: $isSelectedStation) { station in
            StationCard(station: station, branch: branch)
        }
    }
}


