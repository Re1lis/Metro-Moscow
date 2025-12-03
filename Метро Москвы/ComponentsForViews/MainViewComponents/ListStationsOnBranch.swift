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
                        .foregroundColor(.black)
                        .font(.custom("moscowsansregular", size: 18))
                        .overlay{
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 1)
                        }
                }
            }
            
        }
        .ignoresSafeArea()
        .sheet(item: $isSelectedStation) { station in
            StationCard(station: station, branch: branch)
        }
        .navigationTitle(branch.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


