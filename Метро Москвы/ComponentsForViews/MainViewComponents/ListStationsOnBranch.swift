import SwiftUI

struct ListStationsOnBranch: View {
    @State var isSelectedStation: Station? = nil
    @State private var showBranchInfo = false
    let branch: MetroStruct
    @EnvironmentObject var counterStation: counterIsVisitedStations
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(branch.stations) { station in
                    HStack {
                        Button {
                            withAnimation(.easeIn(duration: 0.2)) {
                                self.isSelectedStation = station
                            }
                        } label: {
                            Text(station.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.primary)
                                .font(.custom("moscowsansregular", size: 23))
                        }
                        
                        Spacer()
                        
                        Circle()
                            .fill(station.isVisited ? Color.green : Color.clear)
                            .frame(width: 24, height: 24)
                            .overlay(
                                Circle()
                                    .stroke(station.isVisited ? Color.green : Color.gray, lineWidth: 2)
                            )
                            .overlay(
                                Image(systemName: "checkmark")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.white)
                                    .opacity(station.isVisited ? 1 : 0)
                            )
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(.systemBackground))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(branch.color.color, lineWidth: 2)
                    )
                    .frame(height: 60)
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
