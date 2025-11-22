import SwiftUI

struct MainView: View {
    @EnvironmentObject private var count: counterIsVisitedStations

    var body: some View {
        NavigationStack {
            VStack(spacing: 10){
                VStack {
                    Text("Московское метро")
                        .font(.custom("Kabel-Black", size: 30))
                        .foregroundColor(.red)
                    Text("Самое протяженное метро в мире")
                        .font(.custom("moscowsansregular", size: 22))
                        .foregroundColor(.black)
                }
                
                BlockWithInfoComponent()
                    .environmentObject(count)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    MainView()
        .environmentObject(counterIsVisitedStations())

}
