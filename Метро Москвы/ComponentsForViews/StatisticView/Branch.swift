import SwiftUI


struct BranchProgressCard: View {
    let branch: MetroStruct
    let visited: Int
    let total: Int
    let progress: Float
    let delay: Double
    
    @State private var isVisible = false
    
    var progressPercentage: Int {
        Int(progress * 100)
    }
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Circle()
                    .fill(branch.color.color)
                    .frame(width: 24, height: 24)
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                            .shadow(radius: 1)
                    )
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(branch.name)
                        .font(.custom("moscowsansregular", size: 18))
                        .fontWeight(.medium)
                    
                    Text(branch.number)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text("\(visited)/\(total)")
                    .font(.custom("Kabel-Black", size: 20))
                    .foregroundColor(.primary)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 12)
                    
                    Capsule()
                        .fill(branch.color.color)
                        .frame(width: isVisible ? geometry.size.width * CGFloat(progress) : 0, height: 12)
                        .animation(.spring(response: 0.8, dampingFraction: 0.7).delay(delay), value: isVisible)
                }
            }
            .frame(height: 12)
            
            HStack {
                Text("\(progressPercentage)%")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("\(total - visited) осталось")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 8, y: 3)
        )
        .padding(.horizontal)
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(delay)) {
                isVisible = true
            }
        }
    }
}

