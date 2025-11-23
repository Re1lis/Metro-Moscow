import SwiftUI

struct ListViewBranch: View {
    var body: some View {
        Text("Ветки метро")
            .font(.custom("Kabel-Black", size: 25))
        VStack {
            ForEach (MetroList) { branch in
                NavigationLink {
                    
                } label : {
                    HStack (spacing: 40){
                        ZStack {
                            Circle()
                                .fill(branch.color.color)
                                .frame(width: 40)
                            Text(branch.number)
                                .font(.custom("Kabel-Black", size: 25))
                                .foregroundColor(.white)
                                .padding(.top, 2)
                        }
                        Text(branch.name)
                            .font(.custom("moscowsansregular", size: 25))
                            .foregroundColor(.black)
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .overlay{
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(style: StrokeStyle(lineWidth: 1))
                }
            }
        }
        .padding(.trailing)
        .padding(.leading)
    }
}

#Preview {
    ListViewBranch()
}
