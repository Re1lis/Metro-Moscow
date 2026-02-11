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
                            imageIcon: "tram.fill",
                            buttonText: "Прокатиться по информации",
                            destination: AnyView(TrainView()),
                        )
                        .padding(.horizontal, 20)
                        
                        BlocksForMainView(
                            title: "История",
                            subtitle: "Погрузитесь в увлекательную историю московского метро от самого начала",
                            imageIcon: "text.book.closed.fill",
                            buttonText: "Погружение вглубь метро",
                            destination: AnyView(HistoryView()),
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
