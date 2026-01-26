import SwiftUI
import Combine


final class AppSettings: ObservableObject {
    @Published var isDarkMode: Bool = false
    @Published var notificationsEnabled: Bool = true
    @Published var accentColor: AccentColor = .blue
    
    enum AccentColor: String, CaseIterable, Codable {
        case blue, red, green, purple, orange
        
        var color: Color {
            switch self {
            case .blue: return .blue
            case .red: return .red
            case .green: return .green
            case .purple: return .purple
            case .orange: return .orange
            }
        }
    }
    
    private let darkModeKey = "darkMode"
    private let notificationsKey = "notifications"
    private let accentColorKey = "accentColor"
    
    init() {
        loadSettings()
    }
    
    private func loadSettings() {
        isDarkMode = UserDefaults.standard.bool(forKey: darkModeKey)
        notificationsEnabled = UserDefaults.standard.bool(forKey: notificationsKey)
        
        if let savedColor = UserDefaults.standard.string(forKey: accentColorKey),
           let color = AccentColor(rawValue: savedColor) {
            accentColor = color
        }
    }
    
    func saveSettings() {
        UserDefaults.standard.set(isDarkMode, forKey: darkModeKey)
        UserDefaults.standard.set(notificationsEnabled, forKey: notificationsKey)
        UserDefaults.standard.set(accentColor.rawValue, forKey: accentColorKey)
    }
}



// MARK: - ColorBranch
enum ColorBranch: String, CaseIterable, Codable {
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
    case lightPink
    case pink
    case darkTeal
    
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
        case .lightPink:
            return Color(red: 255/255, green: 204/255, blue: 204/255)
        case .pink:
            return Color(red: 222/255, green: 100/255, blue: 161/255)
        case .darkTeal:
            return Color(red: 3/255, green: 121/255, blue: 95/255)
        }
    }
}

// MARK: - Station (with Codable conformance)
class Station: ObservableObject, Identifiable, Codable {
    var id = UUID()
    var name: String
    var isOpeningYear: Int
    @Published var isVisited: Bool = false
    var depthStation: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case isOpeningYear
        case isVisited
        case depthStation
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        isOpeningYear = try container.decode(Int.self, forKey: .isOpeningYear)
        isVisited = try container.decode(Bool.self, forKey: .isVisited)
        depthStation = try container.decodeIfPresent(String.self, forKey: .depthStation)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(isOpeningYear, forKey: .isOpeningYear)
        try container.encode(isVisited, forKey: .isVisited)
        try container.encodeIfPresent(depthStation, forKey: .depthStation)
    }
    
    init(id: UUID = UUID(), name: String, isOpeningYear: Int, isVisited: Bool, depthStation: String? = nil) {
        self.id = id
        self.name = name
        self.isOpeningYear = isOpeningYear
        self.isVisited = isVisited
        self.depthStation = depthStation
    }
}

// MARK: - MetroStruct (with Codable conformance)
class MetroStruct: ObservableObject, Identifiable, Codable {
    var id = UUID()
    var name: String
    var number: String
    var color: ColorBranch
    @Published var isVisitedStationCounter: Int = 0
    var lenghtBranch: String
    var fullTravelTime: String
    var stations: [Station]
    
    // CodingKeys для Codable
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case number
        case color
        case isVisitedStationCounter
        case lenghtBranch
        case fullTravelTime
        case stations
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        number = try container.decode(String.self, forKey: .number)
        color = try container.decode(ColorBranch.self, forKey: .color)
        isVisitedStationCounter = try container.decode(Int.self, forKey: .isVisitedStationCounter)
        lenghtBranch = try container.decode(String.self, forKey: .lenghtBranch)
        fullTravelTime = try container.decode(String.self, forKey: .fullTravelTime)
        stations = try container.decode([Station].self, forKey: .stations)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(number, forKey: .number)
        try container.encode(color, forKey: .color)
        try container.encode(isVisitedStationCounter, forKey: .isVisitedStationCounter)
        try container.encode(lenghtBranch, forKey: .lenghtBranch)
        try container.encode(fullTravelTime, forKey: .fullTravelTime)
        try container.encode(stations, forKey: .stations)
    }
    
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

// MARK: - Data Persistence Manager
class MetroDataManager: ObservableObject {
    static let shared = MetroDataManager()
    
    private let metroDataKey = "metroData"
    private let visitedCounterKey = "visitedCounter"
    
    @Published var metroList: [MetroStruct] = []
    @Published var counterIsVisited = 0
    
    private init() {
        loadData()
    }
    
    // MARK: - Save Data
    func saveData() {
        do {
            // Save metro data
            let encoder = JSONEncoder()
            let metroData = try encoder.encode(metroList)
            UserDefaults.standard.set(metroData, forKey: metroDataKey)
            
            // Save visited counter
            UserDefaults.standard.set(counterIsVisited, forKey: visitedCounterKey)
            
            print("Data saved successfully")
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
    // MARK: - Load Data
    private func loadData() {
        // Load visited counter
        counterIsVisited = UserDefaults.standard.integer(forKey: visitedCounterKey)
        
        // Load metro data or use initial data
        if let metroData = UserDefaults.standard.data(forKey: metroDataKey) {
            do {
                let decoder = JSONDecoder()
                metroList = try decoder.decode([MetroStruct].self, from: metroData)
                updateCounters()
                print("Data loaded successfully")
            } catch {
                print("Error loading data, using initial data: \(error)")
                metroList = createInitialMetroData()
                saveData()
            }
        } else {
            print("No saved data found, using initial data")
            metroList = createInitialMetroData()
            saveData()
        }
    }
    
    // MARK: - Update counters after loading
    private func updateCounters() {
        counterIsVisited = 0
        for metro in metroList {
            metro.isVisitedStationCounter = metro.stations.filter { $0.isVisited }.count
            counterIsVisited += metro.isVisitedStationCounter
        }
    }
    
    // MARK: - Station visit management
    func toggleStationVisit(station: Station, in metro: MetroStruct) {
        if let stationIndex = metro.stations.firstIndex(where: { $0.id == station.id }) {
            let station = metro.stations[stationIndex]
            
            DispatchQueue.main.async {
                station.isVisited.toggle()
                metro.isVisitedStationCounter = metro.stations.filter { $0.isVisited }.count
                
                if station.isVisited {
                    self.counterIsVisited += 1
                } else {
                    self.counterIsVisited -= 1
                }
                
                self.saveData()
                self.objectWillChange.send()
            }
        }
    }
    
    // MARK: - Reset all data
    func resetAllData() {
        metroList = createInitialMetroData()
        counterIsVisited = 0
        saveData()
        objectWillChange.send()
    }
}

// MARK: - Counter for visited stations
class CounterIsVisitedStations: ObservableObject {
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


func createInitialMetroData() -> [MetroStruct] {
    return [
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
                        ]),
        MetroStruct(name: "Филёвская", number: "4А", color: ColorBranch.lightBlue, isVisitedStationCounter: 0, lenghtBranch: "2,2", fullTravelTime: "5 минут", station:
                        [Station(name: "Деловой центр", isOpeningYear: 2005, isVisited: false, depthStation: "25"),
                         Station(name: "Москва-Сити", isOpeningYear: 2006, isVisited: false, depthStation: "25"),
                        ]),
        MetroStruct(name: "Кольцевая", number: "5", color: ColorBranch.brown, isVisitedStationCounter: 0, lenghtBranch: "19,4", fullTravelTime: "30 минут", station:
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
        MetroStruct(name: "Калужско-Рижская", number: "6", color: ColorBranch.orange, isVisitedStationCounter: 0, lenghtBranch: "37,8", fullTravelTime: "56 минут", station:
                        [Station(name: "Медведково", isOpeningYear: 1978, isVisited: false, depthStation: "10"),
                         Station(name: "Бабушкинская", isOpeningYear: 1978, isVisited: false, depthStation: "10"),
                         Station(name: "Свиблово", isOpeningYear: 1978, isVisited: false, depthStation: "8"),
                         Station(name: "Ботанический сад", isOpeningYear: 1978, isVisited: false, depthStation: "7"),
                         Station(name: "ВДНХ", isOpeningYear: 1958, isVisited: false, depthStation: "53.5"),
                         Station(name: "Алексеевская", isOpeningYear: 1958, isVisited: false, depthStation: "51"),
                         Station(name: "Рижская", isOpeningYear: 1958, isVisited: false, depthStation: "46"),
                         Station(name: "Проспект Мира", isOpeningYear: 1958, isVisited: false, depthStation: "50"),
                         Station(name: "Сухаревская", isOpeningYear: 1972, isVisited: false, depthStation: "43"),
                         Station(name: "Тургеневская", isOpeningYear: 1972, isVisited: false, depthStation: nil),
                         Station(name: "Китай-город", isOpeningYear: 1971, isVisited: false, depthStation: nil),
                         Station(name: "Третьяковская", isOpeningYear: 1971, isVisited: false, depthStation: nil),
                         Station(name: "Октябрьская", isOpeningYear: 1962, isVisited: false, depthStation: nil),
                         Station(name: "Шаболовская", isOpeningYear: 1980, isVisited: false, depthStation: "46.5"),
                         Station(name: "Ленинский проспект", isOpeningYear: 1962, isVisited: false, depthStation: nil),
                         Station(name: "Академическая", isOpeningYear: 1962, isVisited: false, depthStation: "8.5"),
                         Station(name: "Профсоюзная", isOpeningYear: 1962, isVisited: false, depthStation: "7"),
                         Station(name: "Новые Черёмушки", isOpeningYear: 1962, isVisited: false, depthStation: "7"),
                         Station(name: "Калужская", isOpeningYear: 1974, isVisited: false, depthStation: "10"),
                         Station(name: "Беляево", isOpeningYear: 1974, isVisited: false, depthStation: "12"),
                         Station(name: "Коньково", isOpeningYear: 1987, isVisited: false, depthStation: "8"),
                         Station(name: "Тёплый Стан", isOpeningYear: 1987, isVisited: false, depthStation: "8"),
                         Station(name: "Ясенево", isOpeningYear: 1990, isVisited: false, depthStation: "8"),
                         Station(name: "Новоясеневская", isOpeningYear: 1990, isVisited: false, depthStation: "7"),
                        ]),
        MetroStruct(name: "Таганско-Краснопресненская", number: "7", color: ColorBranch.purple, isVisitedStationCounter: 0, lenghtBranch: "42,3", fullTravelTime: "59 минут", station:
                        [Station(name: "Планерная", isOpeningYear: 1975, isVisited: false, depthStation: "6"),
                         Station(name: "Сходненская", isOpeningYear: 1975, isVisited: false, depthStation: "6"),
                         Station(name: "Тушинская", isOpeningYear: 1975, isVisited: false, depthStation: "10.5"),
                         Station(name: "Спартак", isOpeningYear: 2014, isVisited: false, depthStation: "10"),
                         Station(name: "Щукинская", isOpeningYear: 1975, isVisited: false, depthStation: "13"),
                         Station(name: "Октябрьское Поле", isOpeningYear: 1972, isVisited: false, depthStation: "9"),
                         Station(name: "Полежаевская", isOpeningYear: 1972, isVisited: false, depthStation: "10"),
                         Station(name: "Беговая", isOpeningYear: 1972, isVisited: false, depthStation: "9"),
                         Station(name: "Улица 1905 года", isOpeningYear: 1972, isVisited: false, depthStation: "11"),
                         Station(name: "Баррикадная", isOpeningYear: 1972, isVisited: false, depthStation: "30"),
                         Station(name: "Пушкинская", isOpeningYear: 1975, isVisited: false, depthStation: "51"),
                         Station(name: "Кузнецкий Мост", isOpeningYear: 1975, isVisited: false, depthStation: "39.5"),
                         Station(name: "Китай-город", isOpeningYear: 1971, isVisited: false, depthStation: "29"),
                         Station(name: "Таганская", isOpeningYear: 1966, isVisited: false, depthStation: "36"),
                         Station(name: "Пролетарская", isOpeningYear: 1966, isVisited: false, depthStation: "9"),
                         Station(name: "Волгоградский проспект", isOpeningYear: 1966, isVisited: false, depthStation: "8"),
                         Station(name: "Текстильщики", isOpeningYear: 1966, isVisited: false, depthStation: "13"),
                         Station(name: "Кузьминки", isOpeningYear: 1966, isVisited: false, depthStation: "8"),
                         Station(name: "Рязанский проспект", isOpeningYear: 1966, isVisited: false, depthStation: "6"),
                         Station(name: "Выхино", isOpeningYear: 1966, isVisited: false, depthStation: nil),
                         Station(name: "Лермонтовский проспект", isOpeningYear: 2013, isVisited: false, depthStation: "12"),
                         Station(name: "Жулебино", isOpeningYear: 2013, isVisited: false, depthStation: "15"),
                         Station(name: "Котельники", isOpeningYear: 2015, isVisited: false, depthStation: "15"),
                        ]),
        MetroStruct(name: "Калининская", number: "8", color: ColorBranch.yellow, isVisitedStationCounter: 0, lenghtBranch: "16,3", fullTravelTime: "22 минуты", station:
                        [Station(name: "Третьяковская", isOpeningYear: 1986, isVisited: false, depthStation: "46"),
                         Station(name: "Марксистская", isOpeningYear: 1979, isVisited: false, depthStation: "60"),
                         Station(name: "Площадь Ильича", isOpeningYear: 1979, isVisited: false, depthStation: "46"),
                         Station(name: "Авиамоторная", isOpeningYear: 1979, isVisited: false, depthStation: "53"),
                         Station(name: "Шоссе Энтузиастов", isOpeningYear: 1979, isVisited: false, depthStation: "53"),
                         Station(name: "Перово", isOpeningYear: 1979, isVisited: false, depthStation: "9"),
                         Station(name: "Новогиреево", isOpeningYear: 1979, isVisited: false, depthStation: "9"),
                         Station(name: "Новокосино", isOpeningYear: 2012, isVisited: false, depthStation: "9"),
                        ]),
        MetroStruct(name: "Солнцевская", number: "8А", color: ColorBranch.yellow, isVisitedStationCounter: 0, lenghtBranch: "30,9", fullTravelTime: "41 минута", station:
                        [Station(name: "Деловой центр", isOpeningYear: 2014, isVisited: false, depthStation: "25"),
                         Station(name: "Парк Победы", isOpeningYear: 2014, isVisited: false, depthStation: "73.6"),
                         Station(name: "Минская", isOpeningYear: 2017, isVisited: false, depthStation: "15"),
                         Station(name: "Ломоносовский проспект", isOpeningYear: 2017, isVisited: false, depthStation: "15"),
                         Station(name: "Раменки", isOpeningYear: 2017, isVisited: false, depthStation: "15"),
                         Station(name: "Мичуринский проспект", isOpeningYear: 2018, isVisited: false, depthStation: "13"),
                         Station(name: "Озёрная", isOpeningYear: 2018, isVisited: false, depthStation: "25"),
                         Station(name: "Говорово", isOpeningYear: 2018, isVisited: false, depthStation: "14"),
                         Station(name: "Солнцево", isOpeningYear: 2018, isVisited: false, depthStation: "13"),
                         Station(name: "Боровское шоссе", isOpeningYear: 2018, isVisited: false, depthStation: "20"),
                         Station(name: "Новопеределкино", isOpeningYear: 2018, isVisited: false, depthStation: "16"),
                         Station(name: "Рассказовка", isOpeningYear: 2018, isVisited: false, depthStation: "12"),
                         Station(name: "Пыхтино", isOpeningYear: 2023, isVisited: false, depthStation: nil),
                         Station(name: "Аэропорт Внуково", isOpeningYear: 2023, isVisited: false, depthStation: nil),
                        ]),
        MetroStruct(name: "Серпуховско-Тимирязевская", number: "9", color: ColorBranch.gray, isVisitedStationCounter: 0, lenghtBranch: "41,4", fullTravelTime: "1 час", station:
                        [Station(name: "Алтуфьево", isOpeningYear: 1994, isVisited: false, depthStation: "9"),
                         Station(name: "Бибирево", isOpeningYear: 1992, isVisited: false, depthStation: "9.5"),
                         Station(name: "Отрадное", isOpeningYear: 1991, isVisited: false, depthStation: "9"),
                         Station(name: "Владыкино", isOpeningYear: 1991, isVisited: false, depthStation: "10.5"),
                         Station(name: "Петровско-Разумовская", isOpeningYear: 1991, isVisited: false, depthStation: "61"),
                         Station(name: "Тимирязевская", isOpeningYear: 1991, isVisited: false, depthStation: "63.5"),
                         Station(name: "Дмитровская", isOpeningYear: 1991, isVisited: false, depthStation: "59"),
                         Station(name: "Савёловская", isOpeningYear: 1988, isVisited: false, depthStation: "52"),
                         Station(name: "Менделеевская", isOpeningYear: 1988, isVisited: false, depthStation: "48.5"),
                         Station(name: "Цветной бульвар", isOpeningYear: 1988, isVisited: false, depthStation: "50"),
                         Station(name: "Чеховская", isOpeningYear: 1987, isVisited: false, depthStation: "62"),
                         Station(name: "Боровицкая", isOpeningYear: 1986, isVisited: false, depthStation: "46.5"),
                         Station(name: "Полянка", isOpeningYear: 1986, isVisited: false, depthStation: "36.5"),
                         Station(name: "Серпуховская", isOpeningYear: 1983, isVisited: false, depthStation: "43"),
                         Station(name: "Тульская", isOpeningYear: 1983, isVisited: false, depthStation: "9.5"),
                         Station(name: "Нагатинская", isOpeningYear: 1983, isVisited: false, depthStation: "13.5"),
                         Station(name: "Нагорная", isOpeningYear: 1983, isVisited: false, depthStation: "9"),
                         Station(name: "Нахимовский проспект", isOpeningYear: 1983, isVisited: false, depthStation: "9.5"),
                         Station(name: "Севастопольская", isOpeningYear: 1983, isVisited: false, depthStation: "13"),
                         Station(name: "Чертановская", isOpeningYear: 1983, isVisited: false, depthStation: "10.5"),
                         Station(name: "Южная", isOpeningYear: 1983, isVisited: false, depthStation: "10"),
                         Station(name: "Пражская", isOpeningYear: 1985, isVisited: false, depthStation: "9.5"),
                         Station(name: "Улица Академика Янгеля", isOpeningYear: 2000, isVisited: false, depthStation: "8"),
                         Station(name: "Аннино", isOpeningYear: 2001, isVisited: false, depthStation: "8"),
                         Station(name: "Бульвар Дмитрия Донского", isOpeningYear: 2002, isVisited: false, depthStation: "10"),
                        ]),
        MetroStruct(name: "Люблинско-Дмитровская", number: "10", color: ColorBranch.lime, isVisitedStationCounter: 0, lenghtBranch: "43,9", fullTravelTime: "1 час 6 минут", station:
                        [Station(name: "Физтех", isOpeningYear: 2023, isVisited: false, depthStation: nil),
                         Station(name: "Лианозово", isOpeningYear: 2023, isVisited: false, depthStation: nil),
                         Station(name: "Яхромская", isOpeningYear: 2023, isVisited: false, depthStation: nil),
                         Station(name: "Селигерская", isOpeningYear: 2018, isVisited: false, depthStation: "20"),
                         Station(name: "Верхние Лихоборы", isOpeningYear: 2018, isVisited: false, depthStation: nil),
                         Station(name: "Окружная", isOpeningYear: 2018, isVisited: false, depthStation: nil),
                         Station(name: "Петровско-Разумовская", isOpeningYear: 2016, isVisited: false, depthStation: nil),
                         Station(name: "Фонвизинская", isOpeningYear: 2016, isVisited: false, depthStation: nil),
                         Station(name: "Бутырская", isOpeningYear: 2016, isVisited: false, depthStation: nil),
                         Station(name: "Марьина Роща", isOpeningYear: 2010, isVisited: false, depthStation: nil),
                         Station(name: "Достоевская", isOpeningYear: 2010, isVisited: false, depthStation: nil),
                         Station(name: "Трубная", isOpeningYear: 2007, isVisited: false, depthStation: nil),
                         Station(name: "Сретенский бульвар", isOpeningYear: 2007, isVisited: false, depthStation: nil),
                         Station(name: "Чкаловская", isOpeningYear: 1995, isVisited: false, depthStation: nil),
                         Station(name: "Римская", isOpeningYear: 1995, isVisited: false, depthStation: nil),
                         Station(name: "Крестьянская Застава", isOpeningYear: 1995, isVisited: false, depthStation: nil),
                         Station(name: "Дубровка", isOpeningYear: 1999, isVisited: false, depthStation: "62"),
                         Station(name: "Кожуховская", isOpeningYear: 1995, isVisited: false, depthStation: "12"),
                         Station(name: "Печатники", isOpeningYear: 1995, isVisited: false, depthStation: "5"),
                         Station(name: "Волжская", isOpeningYear: 1995, isVisited: false, depthStation: "8"),
                         Station(name: "Люблино", isOpeningYear: 1996, isVisited: false, depthStation: "8"),
                         Station(name: "Братиславская", isOpeningYear: 1996, isVisited: false, depthStation: "8"),
                         Station(name: "Марьино", isOpeningYear: 1996, isVisited: false, depthStation: "8"),
                         Station(name: "Борисово", isOpeningYear: 2011, isVisited: false, depthStation: "10"),
                         Station(name: "Шипиловская", isOpeningYear: 2011, isVisited: false, depthStation: "10"),
                         Station(name: "Зябликово", isOpeningYear: 2011, isVisited: false, depthStation: "15"),
                        ]),
        MetroStruct(name: "Большая кольцевая", number: "11", color: ColorBranch.turquoise, isVisitedStationCounter: 0, lenghtBranch: "70", fullTravelTime: "1 час 30 минут", station:
                        [Station(name: "Савёловская", isOpeningYear: 2018, isVisited: false, depthStation: nil),
                         Station(name: "Петровский парк", isOpeningYear: 2018, isVisited: false, depthStation: nil),
                         Station(name: "ЦСКА", isOpeningYear: 2018, isVisited: false, depthStation: nil),
                         Station(name: "Хорошёвская", isOpeningYear: 2018, isVisited: false, depthStation: nil),
                         Station(name: "Народное Ополчение", isOpeningYear: 2021, isVisited: false, depthStation: nil),
                         Station(name: "Мнёвники", isOpeningYear: 2021, isVisited: false, depthStation: nil),
                         Station(name: "Терехово", isOpeningYear: 2021, isVisited: false, depthStation: nil),
                         Station(name: "Кунцевская", isOpeningYear: 2021, isVisited: false, depthStation: nil),
                         Station(name: "Давыдково", isOpeningYear: 2021, isVisited: false, depthStation: "33"),
                         Station(name: "Аминьевская", isOpeningYear: 2021, isVisited: false, depthStation: "14"),
                         Station(name: "Мичуринский проспект", isOpeningYear: 2021, isVisited: false, depthStation: "19"),
                         Station(name: "Проспект Вернадского", isOpeningYear: 2021, isVisited: false, depthStation: "16"),
                         Station(name: "Новаторская", isOpeningYear: 2021, isVisited: false, depthStation: "11"),
                         Station(name: "Воронцовская", isOpeningYear: 2021, isVisited: false, depthStation: "21"),
                         Station(name: "Зюзино", isOpeningYear: 2021, isVisited: false, depthStation: "17.5"),
                         Station(name: "Каховская", isOpeningYear: 1969, isVisited: false, depthStation: "8"),
                         Station(name: "Варшавская", isOpeningYear: 1969, isVisited: false, depthStation: "9"),
                         Station(name: "Каширская", isOpeningYear: 1969, isVisited: false, depthStation: "7"),
                         Station(name: "Кленовый бульвар", isOpeningYear: 2023, isVisited: false, depthStation: "24.3"),
                         Station(name: "Нагатинский Затон", isOpeningYear: 2023, isVisited: false, depthStation: "27"),
                         Station(name: "Печатники", isOpeningYear: 2023, isVisited: false, depthStation: "30"),
                         Station(name: "Текстильщики", isOpeningYear: 2023, isVisited: false, depthStation: "22"),
                         Station(name: "Нижегородская", isOpeningYear: 2020, isVisited: false, depthStation: "21.8"),
                         Station(name: "Авиамоторная", isOpeningYear: 2020, isVisited: false, depthStation: "19.4"),
                         Station(name: "Лефортово", isOpeningYear: 2020, isVisited: false, depthStation: "26"),
                         Station(name: "Электрозаводская", isOpeningYear: 2020, isVisited: false, depthStation: "20"),
                         Station(name: "Сокольники", isOpeningYear: 2023, isVisited: false, depthStation: nil),
                         Station(name: "Рижская", isOpeningYear: 2023, isVisited: false, depthStation: nil),
                         Station(name: "Марьина Роща", isOpeningYear: 2023, isVisited: false, depthStation: nil),
                        ]),
        MetroStruct(name: "Бутовская", number: "12", color: ColorBranch.darkGray, isVisitedStationCounter: 0, lenghtBranch: "10", fullTravelTime: "16 минут", station:
                        [Station(name: "Битцевский парк", isOpeningYear: 2014, isVisited: false, depthStation: "10"),
                         Station(name: "Лесопарковая", isOpeningYear: 2014, isVisited: false, depthStation: "10"),
                         Station(name: "Улица Старокачаловская", isOpeningYear: 2003, isVisited: false, depthStation: "10"),
                         Station(name: "Улица Скобелевская", isOpeningYear: 2003, isVisited: false, depthStation: "+9.6"),
                         Station(name: "Бульвар Адмирала Ушакова", isOpeningYear: 2003, isVisited: false, depthStation: "+9.6"),
                         Station(name: "Улица Горчакова", isOpeningYear: 2003, isVisited: false, depthStation: "+9.6"),
                         Station(name: "Бунинская аллея", isOpeningYear: 2003, isVisited: false, depthStation: "+9.6"),
                        ]),
        MetroStruct(name: "Некрасовская", number: "15", color: ColorBranch.pink, isVisitedStationCounter: 0, lenghtBranch: "19,6", fullTravelTime: "21 минута", station:
                        [Station(name: "Нижегородская", isOpeningYear: 2020, isVisited: false, depthStation: "21.8"),
                         Station(name: "Стахановская", isOpeningYear: 2020, isVisited: false, depthStation: "19"),
                         Station(name: "Окская", isOpeningYear: 2020, isVisited: false, depthStation: "21"),
                         Station(name: "Юго-Восточная", isOpeningYear: 2020, isVisited: false, depthStation: "20"),
                         Station(name: "Косино", isOpeningYear: 2019, isVisited: false, depthStation: "27"),
                         Station(name: "Улица Дмитриевского", isOpeningYear: 2019, isVisited: false, depthStation: "18"),
                         Station(name: "Лухмановская", isOpeningYear: 2019, isVisited: false, depthStation: "15"),
                         Station(name: "Некрасовка", isOpeningYear: 2019, isVisited: false, depthStation: "16"),
                        ]),
        MetroStruct(name: "Троицкая", number: "16", color: ColorBranch.darkTeal, isVisitedStationCounter: 0, lenghtBranch: "43", fullTravelTime: "31 минута", station:
                        [Station(name: "ЗИЛ", isOpeningYear: 2025, isVisited: false, depthStation: nil),
                         Station(name: "Крымская", isOpeningYear: 2025, isVisited: false, depthStation: nil),
                         Station(name: "Академическая", isOpeningYear: 2025, isVisited: false, depthStation: nil),
                         Station(name: "Вавиловская", isOpeningYear: 2025, isVisited: false, depthStation: nil),
                         Station(name: "Новаторская", isOpeningYear: 2024, isVisited: false, depthStation: "17.6"),
                         Station(name: "Университет дружбы народов", isOpeningYear: 2024, isVisited: false, depthStation: "23"),
                         Station(name: "Генерала Тюленева", isOpeningYear: 2024, isVisited: false, depthStation: "20"),
                         Station(name: "Тютчевская", isOpeningYear: 2024, isVisited: false, depthStation: "12.65"),
                         Station(name: "Корниловская", isOpeningYear: 2024, isVisited: false, depthStation: "16.18"),
                         Station(name: "Коммунарка", isOpeningYear: 2024, isVisited: false, depthStation: "15"),
                         Station(name: "Новомосковская", isOpeningYear: 2024, isVisited: false, depthStation: "8"),
                        ])
    ]
    
    
    
    
}
