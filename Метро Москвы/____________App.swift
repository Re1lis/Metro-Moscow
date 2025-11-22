//
//  ____________App.swift
//  Метро Москвы
//
//  Created by Артем Терзиян on 19.11.2025.
//

import SwiftUI

@main
struct ____________App: App {
    @StateObject private var count = counterIsVisitedStations()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(count)
        }
    }
}
