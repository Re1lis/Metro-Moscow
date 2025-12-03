import SwiftUI
import Combine

// Код, который поможет в будущем создать правильные цвета для каждой ветки
// А точнее в цвет самой ветки
enum ColorBranch: String {
    case red
    
    var color: Color {
        switch self {
            case .red:
            return .red
        }
    }
}


// Структура для станции, основная информация для нее
class Station: ObservableObject, Identifiable {
    var id = UUID()
    var name: String
    var isOpeningYear: Int
    @Published var isVisited: Bool = false
    var depthStation: String? = nil
    
    init(id: UUID = UUID(), name: String, isOpeningYear: Int, isVisited: Bool, depthStation: String? = nil) {
        self.id = id
        self.name = name
        self.isOpeningYear = isOpeningYear
        self.isVisited = isVisited
        self.depthStation = depthStation
    }
}

//Структура для всего метро, тут же есть и структура станции
class MetroStruct: ObservableObject, Identifiable {
    var id = UUID()
    var name: String
    var number: String
    var color: ColorBranch
    @Published var isVisitedStationCounter: Int = 0
    var lenghtBranch: String
    var fullTravelTime: String
    var stations: [Station]

    
    init(id: UUID = UUID(), name: String, number: String, color: ColorBranch, isVisitedStationCounter: Int, lenghtBranch: String, fullTravelTime: String, station: [Station]) {
        self.id = id
        self.name = name
        self.number = number
        self.color = color
        self.stations = station
        self.isVisitedStationCounter = isVisitedStationCounter
        self.lenghtBranch = lenghtBranch
        self.fullTravelTime = fullTravelTime
    }
}


// Часть кода, которая позволяет в будущем использовать переменную counterSation,
// чтобы указывать общее количество станций, которые есть сейчас во всей схеме Московского метрополитена
var counterStations = MetroList.reduce(0) { $0 + $1.stations.count }

// Эта переменная позволит пользователю следить за тем, сколько станций он посетил за все время
class counterIsVisitedStations: ObservableObject {
    @Published var counterIsVisited = 0
    
    func addOne() {
        DispatchQueue.main.async {
            self.counterIsVisited += 1
        }
    }
    
    func takeAwayOne() {
        DispatchQueue.main.async {
            self.counterIsVisited -= 1
        }
    }
}



var MetroList: [MetroStruct] = [
    MetroStruct(name: "Сокольническая", number: "1", color: ColorBranch.red, isVisitedStationCounter: 0, lenghtBranch: "46,5", fullTravelTime: "1 час 10 минут", station:
        [Station(name: "Бульвар Рокоссовского", isOpeningYear: 1990, isVisited: false, depthStation: "8"),
         Station(name: "Черкизовская", isOpeningYear: 1990, isVisited: false, depthStation: "9"),
         Station(name: "Преображенская площадь", isOpeningYear: 1965, isVisited: false, depthStation: "8"),
         Station(name: "Сокольники", isOpeningYear: 1935, isVisited: false, depthStation: "9"),
         Station(name: "Красносельская", isOpeningYear: 1935, isVisited: false, depthStation: "8"),
         Station(name: "Комсомольская", isOpeningYear: 1935, isVisited: false, depthStation: "8"),
         Station(name: "Красные Ворота", isOpeningYear: 1935, isVisited: false, depthStation: "31"),
         Station(name: "Чистые пруды", isOpeningYear: 1935, isVisited: false, depthStation: "35"),
         Station(name: "Лубянка", isOpeningYear: 1935, isVisited: false, depthStation: "32.5"),
         Station(name: "Охотный Ряд", isOpeningYear: 1935, isVisited: false, depthStation: "15"),
         Station(name: "Библиотека имени Ленина", isOpeningYear: 1935, isVisited: false, depthStation: "12"),
         Station(name: "Кропоткинская", isOpeningYear: 1935, isVisited: false, depthStation: "13"),
         Station(name: "Парк культуры", isOpeningYear: 1935, isVisited: false, depthStation: "10.5"),
         Station(name: "Фрунзенская", isOpeningYear: 1957, isVisited: false, depthStation: "42"),
         Station(name: "Спортивная", isOpeningYear: 1935, isVisited: false, depthStation: "42"),
         Station(name: "Воробьевы горы", isOpeningYear: 1959, isVisited: false, depthStation: "+10"),
         Station(name: "Университет", isOpeningYear: 1959, isVisited: false, depthStation: "26,5"),
         Station(name: "Проспект Вернадского", isOpeningYear: 1963, isVisited: false, depthStation: "8"),
         Station(name: "Юго-Западная", isOpeningYear: 1963, isVisited: false, depthStation: "8"),
         Station(name: "Тропарёво", isOpeningYear: 2014, isVisited: false, depthStation: "12"),
         Station(name: "Румянцево", isOpeningYear: 2016, isVisited: false, depthStation: "12"),
         Station(name: "Саларьево", isOpeningYear: 2016, isVisited: false, depthStation: "12"),
         Station(name: "Филатов Луг", isOpeningYear: 2019, isVisited: false, depthStation: nil),
         Station(name: "Прокшино", isOpeningYear: 2019, isVisited: false, depthStation: nil),
         Station(name: "Ольховая", isOpeningYear: 2019, isVisited: false, depthStation: "12"),
         Station(name: "Новомосковская", isOpeningYear: 2019, isVisited: false, depthStation: "8"),
         Station(name: "Потапово", isOpeningYear: 2024, isVisited: false, depthStation: nil),
        ]),
    
]
