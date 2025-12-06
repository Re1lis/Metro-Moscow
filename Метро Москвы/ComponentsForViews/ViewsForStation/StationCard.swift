import SwiftUI

struct StationCard: View {
    let station: Station
    let branch: MetroStruct
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var counterStation: counterIsVisitedStations

    var body: some View {
        VStack{
            Button{
                dismiss()
            } label : {
                Text(station.name)
                    .foregroundColor(.black)
                    .font(.custom("moscowsansregular", size: 22))
            }
            Text(station.isVisited ? "Станция посещена" : "Станция не посещена")
                .font(Font.custom("moscowsansregular", size: 15))
                .foregroundColor(.gray)
        }
        .padding(.top)
        .frame(width: .infinity, alignment: .center)
        Spacer()
        Text("Информация")
            .font(.custom("Kabel-Black", size: 25))
            .frame(width: .infinity, alignment: .center)
        
        VStack {
            Text("Год открытия станции: \(station.isOpeningYear)")
            if let depth = station.depthStation {
                Text("Глубина станции: \(depth) метров")
            } else {
                Text("Глубина станции: не указана")
            }
        }
        .padding()
        .font(.custom("moscowsansregular", size: 20))
        .background(Color.gray)
        .cornerRadius(20)
        Spacer()
        Button{
            withAnimation(.easeIn(duration: 0.7)){
                self.station.isVisited.toggle()
                if !station.isVisited {
                    counterStation.takeAwayOne()
                } else {
                    counterStation.addOne()
                }
            }
        } label : {
            Text(station.isVisited ? "Убрать посещение" : "Посетить станцию")
                .padding()
                .foregroundColor(.black)
                .font(.custom("moscowsansregular", size: 25))
                .background(station.isVisited ? Color.green : Color.red)
                .cornerRadius(20)
        }
    }
}
