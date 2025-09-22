//
//  WeatherAppCWKApp.swift
//  WeatherAppCWK
//
//  Created by Asel Inuke Hidallearachchi on 2024-12-21.
//

import SwiftUI
import SwiftData

@main
struct WeatherAppCWKApp: App {
    @StateObject private var locationVM: StoredPlacesViewModel
    @StateObject private var networkVM = NetworkMonitor()
    
    init() {
        
        let context = DatabaseManager.instance.databaseContainer.mainContext
        _locationVM = StateObject(wrappedValue: StoredPlacesViewModel(context: context))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationVM)
                .environmentObject(networkVM)
                .modelContainer(DatabaseManager.instance.databaseContainer)
        }
    }
}
