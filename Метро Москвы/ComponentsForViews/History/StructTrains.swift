import SwiftUI


class Train: Identifiable {
    let id = UUID()
    let name: String
    let createYear: Int
    let description: String
    let arrayImage: [String]
    
    init(name: String, createYear: Int, description: String, arrayImage: [String]) {
            self.name = name
            self.createYear = createYear
            self.description = description
            self.arrayImage = arrayImage
        }
}


let newTrain = [
    Train(name: "Москва-2024",
          createYear: 2024,
          description: "Самая современная модификация. Улучшенная шумоизоляция, еще более широкие двери и обновленный интерьер. Впервые применены новые материалы отделки и увеличено количество USB-разъемов, включая порты типа Type-C.",
          arrayImage: ["Moscow24-first", "Moscow24-second", "Moscow24-third"]),
    
    Train(name: "Москва-2020",
          createYear: 2020,
          description: "Поезд с рекордно широкими дверями (160 см) и межвагонными переходами. Оснащен интерактивными картами метро, современными системами обеззараживания воздуха и USB-зарядками в каждом сиденье.",
          arrayImage: ["Moscow20-first", "Moscow20-second", "Moscow20-third", "Moscow20-fourth"]),
    
    Train(name: "Москва",
          createYear: 2017,
          description: "Первый поезд со сквозным проходом. Оснащен сенсорными мониторами, подзарядками для гаджетов и усиленным освещением. Отличается плавным ходом и тихой работой двигателей.",
          arrayImage: ["Moscow-first", "Moscow-second", "Moscow-third"]),
    
    Train(name: "Ока",
          createYear: 2012,
          description: "Массовая серия поездов. Имеет современные системы кондиционирования и отопления. В некоторых модификациях реализован сквозной проход между всеми вагонами.",
          arrayImage: ["Oka-first", "Oka-second", "Oka-third"]),
    
    Train(name: "Русич",
          createYear: 2003,
          description: "Спроектирован специально для линий с крутыми поворотами и открытых участков. Вагоны имеют сочлененную конструкцию (длинные 'гармошки') и хорошую теплоизоляцию.",
          arrayImage: ["Rusich-first", "Rusich-second"]),
    
    Train(name: "Номерной (81-717/714)",
          createYear: 1976,
          description: "Самый массовый и узнаваемый поезд метро в мире. Свое название получил из-за того, что не имел буквенного обозначения. Прошел множество модернизаций и до сих пор работает на многих линиях.",
          arrayImage: ["Nums-first", "Nums-second", "Nums-third"]),
    

]


