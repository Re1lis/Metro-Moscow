import SwiftUI
import Combine

// Код, который поможет в будущем создать правильные цвета для каждой ветки
// А точнее в цвет самой ветки
import SwiftUI

enum ColorBranch: String {
    case red
    case green
    case blue
    case lightBlue
    case brown
    case orange
    case purple
    case yellow
    case gray
    case lime
    case turquoise
    case darkGray
    case black
    case lightBlueGray
    case lightPink
    case pink
    case darkTeal
    case darkBlue
    case darkPink
    
    var color: Color {
        switch self {
        case .red:
            return Color(red: 255/255, green: 0/255, blue: 0/255)
        case .green:
            return Color(red: 45/255, green: 190/255, blue: 44/255)
        case .blue:
            return Color(red: 0/255, green: 120/255, blue: 190/255)
        case .lightBlue:
            return Color(red: 0/255, green: 191/255, blue: 255/255)
        case .brown:
            return Color(red: 141/255, green: 91/255, blue: 45/255)
        case .orange:
            return Color(red: 237/255, green: 145/255, blue: 33/255)
        case .purple:
            return Color(red: 128/255, green: 0/255, blue: 128/255)
        case .yellow:
            return Color(red: 255/255, green: 215/255, blue: 2/255)
        case .gray:
            return Color(red: 153/255, green: 153/255, blue: 153/255)
        case .lime:
            return Color(red: 153/255, green: 204/255, blue: 0/255)
        case .turquoise:
            return Color(red: 130/255, green: 192/255, blue: 192/255)
        case .darkGray:
            return Color(red: 35/255, green: 31/255, blue: 32/255)
        case .black:
            return Color(red: 0/255, green: 0/255, blue: 0/255)
        case .lightBlueGray:
            return Color(red: 161/255, green: 179/255, blue: 212/255)
        case .lightPink:
            return Color(red: 255/255, green: 204/255, blue: 204/255)
        case .pink:
            return Color(red: 222/255, green: 100/255, blue: 161/255)
        case .darkTeal:
            return Color(red: 3/255, green: 121/255, blue: 95/255)
        case .darkBlue:
            return Color(red: 39/255, green: 48/255, blue: 63/255)
        case .darkPink:
            return Color(red: 172/255, green: 23/255, blue: 83/255)
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
    MetroStruct(name: "Замоскворецкая", number: "2", color: ColorBranch.green, isVisitedStationCounter: 0, lenghtBranch: "42,8", fullTravelTime: "1 час 4 минуты", station:
            [Station(name: "Ховрино", isOpeningYear: 2017, isVisited: false, depthStation: "14"),
             Station(name: "Беломорская", isOpeningYear: 2018, isVisited: false, depthStation: "18"),
             Station(name: "Речной вокзал", isOpeningYear: 1964, isVisited: false, depthStation: "6"),
             Station(name: "Водный стадион", isOpeningYear: 1964, isVisited: false, depthStation: "6"),
             Station(name: "Войковская", isOpeningYear: 1964, isVisited: false, depthStation: "7"),
             Station(name: "Сокол", isOpeningYear: 1938, isVisited: false, depthStation: "9.6"),
             Station(name: "Аэропорт", isOpeningYear: 1938, isVisited: false, depthStation: "10"),
             Station(name: "Динамо", isOpeningYear: 1938, isVisited: false, depthStation: "39.6"),
             Station(name: "Белорусская", isOpeningYear: 1938, isVisited: false, depthStation: "33.1"),
             Station(name: "Маяковская", isOpeningYear: 1938, isVisited: false, depthStation: "33.1"),
             Station(name: "Тверская", isOpeningYear: 1979, isVisited: false, depthStation: "42"),
             Station(name: "Театральная", isOpeningYear: 1938, isVisited: false, depthStation: "33.9"),
             Station(name: "Новокузнецкая", isOpeningYear: 1943, isVisited: false, depthStation: "37.5"),
             Station(name: "Павелецкая", isOpeningYear: 1943, isVisited: false, depthStation: "33.5"),
             Station(name: "Автозаводская", isOpeningYear: 1943, isVisited: false, depthStation: "11"),
             Station(name: "Технопарк", isOpeningYear: 2015, isVisited: false, depthStation: nil),
             Station(name: "Коломенская", isOpeningYear: 1969, isVisited: false, depthStation: "9"),
             Station(name: "Каширская", isOpeningYear: 1969, isVisited: false, depthStation: "7"),
             Station(name: "Кантемировская", isOpeningYear: 1984, isVisited: false, depthStation: "8"),
             Station(name: "Царицыно", isOpeningYear: 1984, isVisited: false, depthStation: nil),
             Station(name: "Орехово", isOpeningYear: 1984, isVisited: false, depthStation: "9"),
             Station(name: "Домодедовская", isOpeningYear: 1985, isVisited: false, depthStation: "9.5"),
             Station(name: "Красногвардейская", isOpeningYear: 1985, isVisited: false, depthStation: nil),
             Station(name: "Алма-Атинская", isOpeningYear: 2012, isVisited: false, depthStation: "10"),
            ]),
    MetroStruct(name: "Арбатско-Покровская", number: "3", color: ColorBranch.blue, isVisitedStationCounter: 0, lenghtBranch: "45,1", fullTravelTime: "1 час 5 минут", station:
            [Station(name: "Пятницкое шоссе", isOpeningYear: 2012, isVisited: false, depthStation: "11"),
             Station(name: "Митино", isOpeningYear: 2009, isVisited: false, depthStation: "14"),
             Station(name: "Волоколамская", isOpeningYear: 2009, isVisited: false, depthStation: nil),
             Station(name: "Мякинино", isOpeningYear: 2009, isVisited: false, depthStation: nil),
             Station(name: "Строгино", isOpeningYear: 2008, isVisited: false, depthStation: "8"),
             Station(name: "Крылатское", isOpeningYear: 1989, isVisited: false, depthStation: "9.5"),
             Station(name: "Молодёжная", isOpeningYear: 1965, isVisited: false, depthStation: "6.5"),
             Station(name: "Кунцевская", isOpeningYear: 2008, isVisited: false, depthStation: nil),
             Station(name: "Славянский бульвар", isOpeningYear: 2008, isVisited: false, depthStation: nil),
             Station(name: "Парк Победы", isOpeningYear: 2003, isVisited: false, depthStation: "73.6"),
             Station(name: "Киевская", isOpeningYear: 1953, isVisited: false, depthStation: "38"),
             Station(name: "Смоленская", isOpeningYear: 1953, isVisited: false, depthStation: "50"),
             Station(name: "Арбатская", isOpeningYear: 1953, isVisited: false, depthStation: "41"),
             Station(name: "Площадь Революции", isOpeningYear: 1938, isVisited: false, depthStation: "33.6"),
             Station(name: "Курская", isOpeningYear: 1938, isVisited: false, depthStation: "30.7"),
             Station(name: "Бауманская", isOpeningYear: 1944, isVisited: false, depthStation: "32.5"),
             Station(name: "Электрозаводская", isOpeningYear: 1944, isVisited: false, depthStation: "31.5"),
             Station(name: "Семёновская", isOpeningYear: 1944, isVisited: false, depthStation: "40"),
             Station(name: "Партизанская", isOpeningYear: 1944, isVisited: false, depthStation: "9"),
             Station(name: "Измайловская", isOpeningYear: 1961, isVisited: false, depthStation: nil),
             Station(name: "Первомайская", isOpeningYear: 1961, isVisited: false, depthStation: "7"),
             Station(name: "Щёлковская", isOpeningYear: 1963, isVisited: false, depthStation: "8"),
            ]),
    MetroStruct(name: "Филёвская", number: "4", color: ColorBranch.lightBlue, isVisitedStationCounter: 0, lenghtBranch: "14,9", fullTravelTime: "23 минуты", station:
            [Station(name: "Кунцевская", isOpeningYear: 1965, isVisited: false, depthStation: nil),
             Station(name: "Пионерская", isOpeningYear: 1961, isVisited: false, depthStation: nil),
             Station(name: "Филёвский парк", isOpeningYear: 1961, isVisited: false, depthStation: nil),
             Station(name: "Багратионовская", isOpeningYear: 1961, isVisited: false, depthStation: nil),
             Station(name: "Фили", isOpeningYear: 1959, isVisited: false, depthStation: nil),
             Station(name: "Кутузовская", isOpeningYear: 1958, isVisited: false, depthStation: nil),
             Station(name: "Студенческая", isOpeningYear: 1958, isVisited: false, depthStation: nil),
             Station(name: "Киевская", isOpeningYear: 1937, isVisited: false, depthStation: "8.7"),
             Station(name: "Смоленская", isOpeningYear: 1935, isVisited: false, depthStation: "8"),
             Station(name: "Арбатская", isOpeningYear: 1935, isVisited: false, depthStation: "8"),
             Station(name: "Александровский сад", isOpeningYear: 1935, isVisited: false, depthStation: nil),
             Station(name: "Выставочная", isOpeningYear: 2005, isVisited: false, depthStation: "25"),
             Station(name: "Международная", isOpeningYear: 2006, isVisited: false, depthStation: "25"),
            ]),
    MetroStruct(name: "Кольцевая", number: "5", color: ColorBranch.brown, isVisitedStationCounter: 0, lenghtBranch: "19,4", fullTravelTime: "1 час 27.5 минут", station:
            [Station(name: "Парк культуры", isOpeningYear: 1950, isVisited: false, depthStation: nil),
             Station(name: "Октябрьская", isOpeningYear: 1950, isVisited: false, depthStation: nil),
             Station(name: "Добрынинская", isOpeningYear: 1950, isVisited: false, depthStation: nil),
             Station(name: "Павелецкая", isOpeningYear: 1950, isVisited: false, depthStation: nil),
             Station(name: "Таганская", isOpeningYear: 1950, isVisited: false, depthStation: nil),
             Station(name: "Курская", isOpeningYear: 1950, isVisited: false, depthStation: nil),
             Station(name: "Комсомольская", isOpeningYear: 1952, isVisited: false, depthStation: nil),
             Station(name: "Проспект Мира", isOpeningYear: 1952, isVisited: false, depthStation: nil),
             Station(name: "Новослободская", isOpeningYear: 1952, isVisited: false, depthStation: nil),
             Station(name: "Белорусская", isOpeningYear: 1952, isVisited: false, depthStation: "42.5"),
             Station(name: "Краснопресненская", isOpeningYear: 1954, isVisited: false, depthStation: "35.5"),
             Station(name: "Киевская", isOpeningYear: 1954, isVisited: false, depthStation: "53"),
            ]),
]



final class AppSettings: ObservableObject {
    @Published var isDarkMode: Bool = false
    @Published var notificationsEnabled: Bool = true
}

