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

let newTrain = Train(name: "Москва-2020",
                     createYear: 2017,
                     description: "В поезде нового поколения «Москва-2020» комфорта и удобств станет ещё больше. Поезд может перевозить более 1500 человек. Расширенный проход между рядами, а также появление USB-зарядок (их больше 360 штук)!",
                     arrayImage: ["1", "2", "3"])


