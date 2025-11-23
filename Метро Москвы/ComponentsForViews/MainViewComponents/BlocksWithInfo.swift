import SwiftUI

struct BlockWithInfoComponent: View {
    @EnvironmentObject private var count: counterIsVisitedStations
    var body: some View {
        HStack(spacing: 20){
            VStack{
                NavigationLink {
                    
                } label : {
                    VStack {
                        Text("\(count.counterIsVisited) / \(counterStations)")
                            .font(.custom("moscowsansregular", size: 25))
                            .foregroundColor(.black)
                        Text("Посещено станций")
                            .font(.custom("moscowsansregular", size: 24))
                            .foregroundColor(.black)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 1)
                    )
                }
            }
        }
        .padding(.trailing)
        .padding(.leading)
    }
}

#Preview {
    BlockWithInfoComponent()
        .environmentObject(counterIsVisitedStations())
}
