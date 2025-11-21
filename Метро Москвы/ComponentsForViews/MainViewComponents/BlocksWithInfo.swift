import SwiftUI

struct BlockWithInfoComponent: View {
    var body: some View {
        HStack {
            Text("Hello World")
        // Добавить два блока, общее количество станций, а также количество станций, которые пользователь посетил, возможно, можно будет посмотреть список этих станций, сделать через NavigationStack
        }
    }
}

#Preview {
    BlockWithInfoComponent()
}
