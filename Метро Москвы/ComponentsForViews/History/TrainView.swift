import SwiftUI


struct TrainView: View {
    let trains = newTrain
    
    var body: some View {
        ZStack{
            ScrollView{
                LazyVStack(spacing: 25) {
                    ForEach(trains) { item in
                        TrainCard(train: item)
                        }
                    }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Поезда Метро")
                    .font(.custom("Kabel-Black", size: 28))
                    .foregroundColor(.red)
            }
        } 
    }
}

#Preview{
    TrainView()
}
