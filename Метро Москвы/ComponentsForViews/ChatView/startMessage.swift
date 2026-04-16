
import SwiftUI

struct AIWelcomeCard: View {
    var onClose: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "sparkles")
                    .foregroundColor(.blue)
                
                Text("ИИ-помощник")
                    .font(.custom("Kabel-Black", size: 18))
                
                Spacer()
                
                Button(action: onClose) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                }
            }
            
            Text("Я помогу тебе разобраться в сериях вагонов, истории станций и маршрутах.")
                .font(.custom("moscowsansregular", size: 14))
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
