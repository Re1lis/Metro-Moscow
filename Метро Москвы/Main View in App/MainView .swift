import SwiftUI

struct MainView: View {
    @EnvironmentObject private var count: CounterIsVisitedStations
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 10){
                    VStack {
                        Text("Московское метро")
                            .font(.custom("Kabel-Black", size: 30))
                            .foregroundColor(.red)
                        Text("Самое протяженное метро в мире")
                            .font(.custom("moscowsansregular", size: 22))
                            .foregroundColor(.primary)
                    }
                    
//                    BlockWithInfoComponent()
//                        .environmentObject(count)
//                        .padding(.bottom, 10)
                    
                    ListViewBranch()
                        .environmentObject(CounterIsVisitedStations())
                }
                .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(CounterIsVisitedStations())
}
