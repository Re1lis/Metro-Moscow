import SwiftUI

struct HistoryView: View {
    @State private var selectedPeriod = 0
    
    let periods = [
        HistoryPeriod(
            title: "Рождение легенды",
            subtitle: "1902-1935",
            description: "Ещё до революции, в 1902 году, инженер Петр Балинский представил думе смелый проект: 105 километров подземных дорог, величественные вокзалы и снос 552 домов в центре. Городские чиновники вынесли вердикт: «Утопия! Москва — не Лондон».",
            icon: "sparkles"
        ),
        HistoryPeriod(
            title: "Первое чудо",
            subtitle: "1935",
            description: "15 мая 1935 года, 7:00 утра. На «Сокольниках» собираются тысячи людей. Первый поезд из вагонов типа «А» отправляется в путь по линии: «Сокольники» — «Парк культуры».",
            icon: "train.side.front.car"
        ),
        HistoryPeriod(
            title: "Метро-крепость",
            subtitle: "1941-1945",
            description: "22 июня 1941 года. В метро идёт обычный день. В 12:15 по радио — выступление Молотова о начале войны. Через 2 часа поступает приказ: превратить метро в бомбоубежище.",
            icon: "shield"
        ),
        HistoryPeriod(
            title: "Сталинские дворцы",
            subtitle: "1945-1955",
            description: "После войны станции становятся ещё роскошнее. Это уже не просто транспорт — это монументы Победе. «Комсомольская»-кольцевая — настоящий дворец с мозаиками из смальты.",
            icon: "building.columns"
        ),
        HistoryPeriod(
            title: "Оттепель",
            subtitle: "1955-1970",
            description: "1955 год. Постановление «Об устранении излишеств в проектировании». Хрущёв требует: «Станции должны быть как хлеб — дешёвые и нужные».",
            icon: "leaf"
        ),
        HistoryPeriod(
            title: "Современность",
            subtitle: "1970-2020",
            description: "70-е — время «спальных районов». Нужно связать окраины с центром. Строят глубокие линии: Калужско-Рижскую, Серпуховско-Тимирязевскую.",
            icon: "cpu"
        ),
        HistoryPeriod(
            title: "Наши дни",
            subtitle: "2000-...",
            description: "265 станций, 15 линий общей длиной 460 км. Ежедневный пассажиропоток — 9 миллионов человек. Коты-сотрудники с 1950-х — официальные коты на депо.",
            icon: "number"
        )
    ]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Периоды истории")) {
                    periodCardView
                    
                    HStack(spacing: 12) {
                        Button(action: {
                            if selectedPeriod > 0 {
                                withAnimation {
                                    selectedPeriod -= 1
                                }
                            }
                        }) {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Назад")
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color(.systemGray6))
                            .foregroundColor(selectedPeriod > 0 ? .primary : .gray)
                            .cornerRadius(8)
                        }
                        .disabled(selectedPeriod == 0)
                        
                        Button(action: {
                            if selectedPeriod < periods.count - 1 {
                                withAnimation {
                                    selectedPeriod += 1
                                }
                            } else {
                                withAnimation {
                                    selectedPeriod = 0
                                }
                            }
                        }) {
                            HStack {
                                Text(selectedPeriod == periods.count - 1 ? "В начало" : "Далее")
                                Image(systemName: "chevron.right")
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                    }
                    .buttonStyle(.plain)
                }
                
                Section(header: Text("Быстрые факты")) {
                    ForEach(getFacts(for: selectedPeriod), id: \.self) { fact in
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 6))
                                .foregroundColor(.red)
                                .padding(.top, 6)
                            
                            Text(fact)
                                .font(.subheadline)
                        }
                        .padding(.vertical, 4)
                    }
                }
                
                Section(header: Text("Навигация")) {
                    HStack {
                        Text("Текущий период")
                        Spacer()
                        Text("\(selectedPeriod + 1) из \(periods.count)")
                            .foregroundColor(.red)
                    }
                    
                    Picker("Выбрать период", selection: $selectedPeriod) {
                        ForEach(0..<periods.count, id: \.self) { index in
                            Text(periods[index].title).tag(index)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .navigationTitle("История метро")
        }
    }
    
    private var periodCardView: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: periods[selectedPeriod].icon)
                    .foregroundColor(.red)
                    .font(.title2)
                    .frame(width: 40)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(periods[selectedPeriod].title)
                        .font(.headline)
                    
                    Text(periods[selectedPeriod].subtitle)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            
            Text(periods[selectedPeriod].description)
                .font(.body)
                .foregroundColor(.primary)
            
            Divider()
            
            HStack {
                Text("Глава \(selectedPeriod + 1) из \(periods.count)")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                HStack(spacing: 4) {
                    ForEach(0..<periods.count, id: \.self) { index in
                        Circle()
                            .fill(index == selectedPeriod ? Color.red : Color.gray.opacity(0.3))
                            .frame(width: 6, height: 6)
                    }
                }
            }
        }
        .padding(.vertical, 8)
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
}

#Preview {
    HistoryView()
}
