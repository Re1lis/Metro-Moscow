import SwiftUI

struct HistoryView: View {
    @State private var selectedPeriod = 0
    @State private var showDetail = true
    
    let periods = [
        HistoryPeriod(
            title: "Рождение легенды",
            subtitle: "1902-1935",
            description: "Ещё до революции, в 1902 году, инженер Петр Балинский представил думе смелый проект: 105 километров подземных дорог, величественные вокзалы и снос 552 домов в центре. Городские чиновники вынесли вердикт: «Утопия! Москва — не Лондон».",
            icon: "sparkles",
            color: .purple
        ),
        HistoryPeriod(
            title: "Первое чудо",
            subtitle: "1935",
            description: "15 мая 1935 года, 7:00 утра. На «Сокольниках» собираются тысячи людей. Первый поезд из вагонов типа «А» отправляется в путь по линии: «Сокольники» — «Парк культуры».",
            icon: "train.side.front.car",
            color: .red
        ),
        HistoryPeriod(
            title: "Метро-крепость",
            subtitle: "1941-1945",
            description: "22 июня 1941 года. В метро идёт обычный день. В 12:15 по радио — выступление Молотова о начале войны. Через 2 часа поступает приказ: превратить метро в бомбоубежище.",
            icon: "shield",
            color: .orange
        ),
        HistoryPeriod(
            title: "Сталинские дворцы",
            subtitle: "1945-1955",
            description: "После войны станции становятся ещё роскошнее. Это уже не просто транспорт — это монументы Победе. «Комсомольская»-кольцевая — настоящий дворец с мозаиками из смальты.",
            icon: "building.columns",
            color: .yellow
        ),
        HistoryPeriod(
            title: "Оттепель",
            subtitle: "1955-1970",
            description: "1955 год. Постановление «Об устранении излишеств в проектировании». Хрущёв требует: «Станции должны быть как хлеб — дешёвые и нужные».",
            icon: "leaf",
            color: .green
        ),
        HistoryPeriod(
            title: "Современность",
            subtitle: "1970-2020",
            description: "70-е — время «спальных районов». Нужно связать окраины с центром. Строят глубокие линии: Калужско-Рижскую, Серпуховско-Тимирязевскую.",
            icon: "cpu",
            color: .blue
        ),
        HistoryPeriod(
            title: "Наши дни",
            subtitle: "2000-...",
            description: "265 станций, 15 линий общей длиной 460 км. Ежедневный пассажиропоток — 9 миллионов человек. Коты-сотрудники с 1950-х — официальные коты на депо.",
            icon: "number",
            color: .indigo
        )
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        periodCardView
                            .padding(.top, 20)
                            .padding(.horizontal, 20)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    showDetail.toggle()
                                }
                            }
                        
                        if showDetail {
                            VStack(alignment: .leading, spacing: 20) {
                                Text(periods[selectedPeriod].description)
                                    .font(.custom("moscowsansregular", size: 18))
                                    .foregroundColor(.primary)
                                    .lineSpacing(6)
                                    .padding(.horizontal, 20)
                                
                                VStack(spacing: 15) {
                                    Text("Быстрые факты")
                                        .font(.custom("Kabel-Black", size: 22))
                                        .foregroundColor(periods[selectedPeriod].color)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.horizontal, 20)
                                    
                                    ForEach(getFacts(for: selectedPeriod), id: \.self) { fact in
                                        HStack(spacing: 12) {
                                            Circle()
                                                .fill(periods[selectedPeriod].color)
                                                .frame(width: 8, height: 8)
                                            
                                            Text(fact)
                                                .font(.custom("moscowsansregular", size: 16))
                                                .foregroundColor(.primary)
                                                .lineSpacing(4)
                                            
                                            Spacer()
                                        }
                                        .padding(.horizontal, 20)
                                    }
                                }
                            }
                            .transition(.opacity.combined(with: .move(edge: .top)))
                        }
                        
                        HStack(spacing: 15) {
                            Button(action: {
                                if selectedPeriod > 0 {
                                    withAnimation(.spring()) {
                                        selectedPeriod -= 1
                                        
                                    }
                                }
                            }) {
                                HStack(spacing: 8) {
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 18, weight: .semibold))
                                    Text("Назад")
                                        .font(.custom("Kabel-Black", size: 18))
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color(.systemGray6))
                                .foregroundColor(selectedPeriod > 0 ? .primary : .gray)
                                .cornerRadius(15)
                                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                            }
                            .disabled(selectedPeriod == 0)
                            
                            Button(action: {
                                if selectedPeriod < periods.count - 1 {
                                    withAnimation(.spring()) {
                                        selectedPeriod += 1
                                        
                                    }
                                } else {
                                    withAnimation(.spring()) {
                                        selectedPeriod = 0
                                        
                                    }
                                }
                            }) {
                                HStack(spacing: 8) {
                                    Text(selectedPeriod == periods.count - 1 ? "В начало" : "Далее")
                                        .font(.custom("Kabel-Black", size: 18))
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 18, weight: .semibold))
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(periods[selectedPeriod].color)
                                .foregroundColor(.white)
                                .cornerRadius(15)
                                .shadow(color: periods[selectedPeriod].color.opacity(0.3), radius: 8, x: 0, y: 4)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        VStack(spacing: 15) {
                            Text("Периоды истории")
                                .font(.custom("Kabel-Black", size: 22))
                                .foregroundColor(.primary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(0..<periods.count, id: \.self) { index in
                                        Button(action: {
                                            withAnimation(.spring()) {
                                                selectedPeriod = index
                                            }
                                        }) {
                                            VStack(spacing: 8) {
                                                Image(systemName: periods[index].icon)
                                                    .font(.system(size: 24))
                                                    .foregroundColor(index == selectedPeriod ? .white : periods[index].color)
                                                    .frame(width: 50, height: 50)
                                                    .background(
                                                        Circle()
                                                            .fill(index == selectedPeriod ? periods[index].color : periods[index].color.opacity(0.1))
                                                    )
                                                
                                                Text(periods[index].subtitle)
                                                    .font(.custom("moscowsansregular", size: 14))
                                                    .foregroundColor(.secondary)
                                                    .lineLimit(1)
                                            }
                                            .frame(width: 80)
                                        }
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                        .padding(.top, 10)
                        
                        Spacer()
                            .frame(height: 30)
                    }
                    .padding(.bottom, 30)
                }
            }
            .navigationTitle("История метро")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("История метро")
                        .font(.custom("Kabel-Black", size: 28))
                        .foregroundColor(.blue)
                }
            }
        }
    }
    
    private var periodCardView: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 15) {
                Image(systemName: periods[selectedPeriod].icon)
                    .font(.system(size: 32))
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                periods[selectedPeriod].color,
                                periods[selectedPeriod].color.opacity(0.8)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(15)
                    .shadow(color: periods[selectedPeriod].color.opacity(0.4), radius: 10, x: 0, y: 5)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(periods[selectedPeriod].title)
                        .font(.custom("Kabel-Black", size: 24))
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    
                    Text(periods[selectedPeriod].subtitle)
                        .font(.custom("moscowsansregular", size: 16))
                        .foregroundColor(periods[selectedPeriod].color)
                }
                
                Spacer()
                
                VStack {
                    Text("\(selectedPeriod + 1)")
                        .font(.custom("Kabel-Black", size: 32))
                        .foregroundColor(periods[selectedPeriod].color)
                    
                    Text("/\(periods.count)")
                        .font(.custom("moscowsansregular", size: 14))
                        .foregroundColor(.secondary)
                }
            }
            
            HStack(spacing: 4) {
                ForEach(0..<periods.count, id: \.self) { index in
                    Capsule()
                        .fill(index == selectedPeriod ? periods[selectedPeriod].color : Color.gray.opacity(0.3))
                        .frame(width: index == selectedPeriod ? 30 : 8, height: 4)
                        .animation(.spring(), value: selectedPeriod)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.08), radius: 15, x: 0, y: 5)
        )
    }
    
    func getFacts(for period: Int) -> [String] {
        switch period {
        case 0:
            return [
                "Первый проект в 1902 году",
                "Начало стройки в 1931",
                "Работали вручную, лопатами"
            ]
        case 1:
            return [
                "Открытие 15 мая 1935",
                "11 станций, 13 км",
                "Билет стоил 50 копеек"
            ]
        case 2:
            return [
                "217 детей родилось в метро",
                "Бомбоубежище для тысяч",
                "1 день простоя (16.10.1941)"
            ]
        case 3:
            return [
                "Мозаики из блокадного Ленинграда",
                "76 бронзовых скульптур",
                "Кроссовки на фреске «Сенокос»"
            ]
        case 4:
            return [
                "Борьба с излишествами",
                "Первая АЛС в мире",
                "Станции-сороконожки"
            ]
        case 5:
            return [
                "МЦК запущен в 2018",
                "Вагоны с кондиционерами",
                "Система ГЛОНАСС"
            ]
        case 6:
            return [
                "265 станций, 460 км",
                "9 млн пассажиров в день",
                "500 котов-сотрудников"
            ]
        default:
            return []
        }
    }
}

struct HistoryPeriod {
    let title: String
    let subtitle: String
    let description: String
    let icon: String
    let color: Color
}

#Preview {
    HistoryView()
}
