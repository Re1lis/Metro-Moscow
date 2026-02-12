import SwiftUI

struct BlocksForMainView: View {
    let title: String
    let subtitle: String
    let imageIcon: String
    let buttonText: String
    let destination: AnyView
    let themeColor: Color
    
    init(title: String,
         subtitle: String,
         imageIcon: String,
         buttonText: String,
         color: Color,
         destination: AnyView)
    {
        self.title = title
        self.subtitle = subtitle
        self.imageIcon = imageIcon
        self.buttonText = buttonText
        self.themeColor = color
        self.destination = destination
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 16) {
                Image(systemName: imageIcon)
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(themeColor)
                    .cornerRadius(16)
                    .shadow(color: themeColor.opacity(0.3), radius: 8, x: 0, y: 4)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(title)
                        .font(.custom("Kabel-Black", size: 24))
                        .foregroundColor(.primary)
                    
                    Text(subtitle)
                        .font(.custom("moscowsansregular", size: 15))
                        .opacity(0.9)
                }
                
                Spacer()
            }
            
            Rectangle()
                .fill(themeColor.opacity(0.3))
                .frame(height: 2)
                .cornerRadius(1)
            
            NavigationLink(destination: destination) {
                HStack {
                    Text(buttonText)
                        .font(.custom("Kabel-Black", size: 18))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(themeColor)
                .cornerRadius(12)
                .shadow(color: themeColor.opacity(0.3), radius: 8, x: 0, y: 4)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(24)
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(themeColor.opacity(0.4), lineWidth: 1) 
        )
    }
}
