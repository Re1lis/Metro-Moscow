import SwiftUI

struct ListStationsOnBranch: View {
    @State var isSelectedStation: Station? = nil
    let branch: MetroStruct
    var body: some View {
        ScrollView {
            VStack (spacing: 10) {
                ForEach(branch.stations) { station in
                    Button {
                        withAnimation(.easeIn(duration: 2)){
                            self.isSelectedStation = station
                        }
                    } label : {
                        Text(station.name)
                            .frame(maxWidth: .infinity, maxHeight: 60)
                            .foregroundColor(.black)
                            .font(.custom("moscowsansregular", size: 23))
                            .overlay{
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.black, lineWidth: 1)
                            }
                    }
                    .frame(width: .infinity, height: 50)
                }
                
            }
            .padding(.leading)
            .padding(.trailing)
            .sheet(item: $isSelectedStation) { station in
                StationCard(station: station, branch: branch)
            }
            .navigationTitle(branch.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


