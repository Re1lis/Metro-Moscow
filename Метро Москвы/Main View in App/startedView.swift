import SwiftUI

struct StartedView: View {
    @State private var letters: [Bool] = Array(repeating: false, count: 5)
    @State private var showProgress = false
    @State private var showComplete = false
    @State private var progressValue: CGFloat = 0
    @EnvironmentObject var appSettings: AppSettings
    
    var body: some View {
        ZStack {
            Color(red: 0.2, green: 0.2, blue: 0.2)         .ignoresSafeArea()
            
            VStack(spacing: 30) {
                HStack(spacing: 0) {
                    Text("M")
                        .font(.custom("Kabel-Black", size: 180))
                        .foregroundColor(.red)
                        .scaleEffect(letters[0] ? 1 : 0.3)
                        .rotationEffect(.degrees(letters[0] ? 0 : -90))
                        .opacity(letters[0] ? 1 : 0)
                    
                    VStack(alignment: .leading, spacing: -15) {
                        Text("етро")
                            .font(.custom("moscowsansregular", size: 55))
                            .foregroundColor(.white)
                            .opacity(letters[1] ? 1 : 0)
                            .offset(y: letters[1] ? 0 : 20)
                        
                        Text("осквы")
                            .font(.custom("moscowsansregular", size: 55))
                            .foregroundColor(.white)
                            .opacity(letters[2] ? 1 : 0)
                            .offset(y: letters[2] ? 0 : 20)
                    }
                    .padding(.leading, 5)
                }
                
                ZStack {
                    Capsule()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 200, height: 4)
                    
                    Capsule()
                        .fill(Color.red)
                        .frame(width: progressValue * 200, height: 4)
                }
                .padding(.top, 20)
                
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.3), lineWidth: 4)
                        .frame(width: 70, height: 70)
                    
                    Circle()
                        .trim(from: 0, to: progressValue)
                        .stroke(Color.red, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                        .frame(width: 70, height: 70)
                        .rotationEffect(.degrees(-90))
                    
                    if showComplete {
                        Image(systemName: "checkmark")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.red)
                    } else {
                        Circle()
                            .fill(Color.red.opacity(0.2))
                            .frame(width: 30, height: 30)
                            .scaleEffect(showProgress ? 1 : 0)
                    }
                }
                .padding(.top, 30)
                
                if showComplete {
                    Text("ГОТОВО!")
                        .font(.custom("moscowsansregular", size: 22))
                        .foregroundColor(.red)
                        .scaleEffect(1.2)
                } else {
                    Text("ЗАГРУЗКА...")
                        .font(.custom("moscowsansregular", size: 18))
                        .foregroundColor(.gray)
                        .opacity(showProgress ? 1 : 0)
                        .scaleEffect(showProgress ? 1 : 0.8)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                    letters[0] = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                    letters[1] = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                    letters[2] = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation(.easeInOut(duration: 1.2)) {
                    showProgress = true
                    progressValue = 1.0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    withAnimation(.spring()) {
                        showComplete = true
                    }
                }
            }
        }
    }
}

#Preview {
    StartedView()
}
