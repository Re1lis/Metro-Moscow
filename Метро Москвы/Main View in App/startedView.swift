import SwiftUI

struct StartedView: View {
//    @AppStorage("isOnAppAgain") private var isOnAppAgain: Bool = false
    
    @State private var isOnAppAgain: Bool = false
    
    var body: some View {
        VStack (spacing: 50) {
            HStack {
                Text("M")
                    .font(.custom("Kabel-Black", size: 190))
                    .foregroundColor(Color.red)
                Text("етро\nосквы")
                    .font(.custom("moscowsansregular", size: 50))
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    StartedView()
}
