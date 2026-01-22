import SwiftUI

struct ListViewBranch: View {
    var body: some View {
        VStack {
            Text("Ветки метро")
                .font(.custom("Kabel-Black", size: 25))
                .padding(.bottom, 15)
                
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(MetroList) { branch in
                        NavigationLink(destination: ListStationsOnBranch(branch: branch)) {
                            HStack(spacing: 20) {
                                ZStack {
                                    Circle()
                                        .fill(branch.color.color)
                                        .frame(width: 50, height: 50)
                                    Text(branch.number)
                                        .font(.custom("Kabel-Black", size: 25))
                                        .foregroundColor(.white)
                                        .padding(.leading, 1)
                                        .padding(.top, 1)
                                }
                                
                                Text(branch.name)
                                    .font(.custom("moscowsansregular", size: 22))
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.9)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 18))
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(.systemBackground))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                    )
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationView {
        ListViewBranch()
    }
}
