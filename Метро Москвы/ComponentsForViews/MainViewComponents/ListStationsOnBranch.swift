import SwiftUI

struct ListStationsOnBranch: View {
    @State var isSelectedStation: Station? = nil
    @State private var showBranchInfo = false
    let branch: MetroStruct
    
    var body: some View {
        ScrollView {
            VStack (spacing: 10) {
                ForEach(branch.stations) { station in
                    Button {
                        withAnimation(.easeIn(duration: 0.2)) {
                            self.isSelectedStation = station
                        }
                    } label : {
                        Text(station.name)
                            .frame(maxWidth: .infinity, maxHeight: 60)
                            .foregroundColor(.primary)
                            .font(.custom("moscowsansregular", size: 23))
                            .overlay{
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.primary, lineWidth: 1)
                            }
                    }
                    .frame(height: 50)
                }
            }
            .padding(.horizontal)
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
                    Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.blue)
                }
            }
        }
    }
}
