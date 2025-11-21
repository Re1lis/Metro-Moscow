import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            Text("Московское метро")
                .font(.custom("Kabel-Black", size: 30))
                .foregroundColor(.red)
            Text("Самое протяженное метро в мире")
                .font(.custom("moscowsansregular", size: 22))
                .foregroundColor(.gray)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MainView()
}
