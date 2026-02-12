import SwiftUI

struct MainViewHistory: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        BlocksForMainView(
                            title: "Поезда",
                            subtitle: "Узнайте, какие поезда возят людей каждый день!",
                            imageIcon: "tram.tunnel.fill",
                            buttonText: "Прокатиться по информации", color: Color.blue,
                            destination: AnyView(TrainView()),
                        )
                        .padding(.horizontal, 20)
                        
                        BlocksForMainView(
                            title: "История",
                            subtitle: "Погрузитесь в увлекательную историю московского метро от самого начала!",
                            imageIcon: "text.book.closed.fill",
                            buttonText: "Погружение вглубь метро", color: Color.green,
                            destination: AnyView(HistoryView()),
                        )
                        .padding(.horizontal, 20)
                        
                        BlocksForMainView(
                            title: "Тематические поезда",
                            subtitle: "Узнайте, какие тематические поезда появляются или когда-то ездили по метро!",
                            imageIcon: "train.side.front.car",
                            buttonText: "Погружение вглубь метро", color: Color.purple,
                            destination: AnyView(ThemesTrain()),
                        )
                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 30)
                }
            }
            .navigationTitle("Информация о метро")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Информация о метро")
                        .font(.custom("Kabel-Black", size: 28))
                        .foregroundColor(.red)
                }
            }
        }
    }
}

#Preview {
    MainViewHistory()
}
