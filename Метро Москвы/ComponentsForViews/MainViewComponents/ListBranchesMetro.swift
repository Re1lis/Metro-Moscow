import SwiftUI

struct ListViewBranch: View {
    @EnvironmentObject var metroManager: MetroDataManager
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                     
                    LazyVStack(spacing: 16) {
                        ForEach(metroManager.metroList) { branch in
                            NavigationLink(destination: ListStationsOnBranch(branch: branch)) {
                                HStack(spacing: 20) {
                                    ZStack {
                                        Circle()
                                            .fill(branch.color.color)
                                            .frame(width: 60, height: 60)
                                            .shadow(color: branch.color.color.opacity(0.4), radius: 8, y: 4)
                                        
                                        Text(branch.number)
                                            .font(.custom("Kabel-Black", size: 28))
                                            .foregroundColor(.white)
                                            .shadow(color: .black.opacity(0.2), radius: 1, y: 1)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(branch.name)
                                            .font(.custom("moscowsansregular", size: 20))
                                            .foregroundColor(.primary)
                                            .fontWeight(.medium)
                                            .lineLimit(2)
                                        
                                        HStack(spacing: 15) {
                                            Label("\(branch.stations.count)", systemImage: "tram.fill")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                            
                                            Label(branch.lenghtBranch, systemImage: "ruler")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    VStack {
                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(branch.color.color.opacity(0.7))
                                            .padding(10)
                                            .background(
                                                Circle()
                                                    .fill(branch.color.color.opacity(0.1))
                                            )
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 18)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color(.systemBackground))
                                        .shadow(color: .black.opacity(0.3), radius: 10, y: 5)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(branch.color.color.opacity(0.3), lineWidth: 1)
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 5)
                    .padding(.bottom, 30)
                }
            }
            .background(Color(.systemBackground))
        }
    }
}

#Preview {
    ListViewBranch()
        .environmentObject(MetroDataManager.shared)
}
