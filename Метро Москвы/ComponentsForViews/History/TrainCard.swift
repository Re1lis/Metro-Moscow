import SwiftUI

struct TrainCard: View {
    let train: Train
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                Text(train.name)
                    .font(.custom("Kabel-Black", size: 28))
                    .foregroundColor(.primary)
                
                HStack {
                    Image(systemName: "calendar")
                        .font(.caption)
                    Text("Год выпуска: \(String(train.createYear))")
                        .font(.custom("moscowsansregular", size: 14))
                }
                .foregroundColor(.secondary)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(train.arrayImage, id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 280, height: 180)
                            .cornerRadius(20)
                            .clipped()
                            .scrollTransition { content, phase in
                                content
                                    .scaleEffect(phase.isIdentity ? 1 : 0.85)
                                    .opacity(phase.isIdentity ? 1 : 0.7)
                            }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .contentMargins(20, for: .scrollContent)
           
            
            VStack(alignment: .leading, spacing: 8) {
                Text("О ПОЕЗДЕ")
                    .font(.custom("Kabel-Black", size: 14))
                    .foregroundColor(.secondary)
                
                Text(train.description)
                    .font(.custom("moscowsansregular", size: 16))
                    .foregroundColor(.primary.opacity(0.8))
                    .lineSpacing(4)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 25)
        }
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.15), radius: 15, x: 0, y: 8)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.red.opacity(0.5), lineWidth: 1)
        )
        .padding(.vertical, 10)
    }
}

#Preview {
    ZStack {
        Color(.systemGroupedBackground).ignoresSafeArea()
        ScrollView {
            TrainCard(train: newTrain[0])
        }
    }
}
