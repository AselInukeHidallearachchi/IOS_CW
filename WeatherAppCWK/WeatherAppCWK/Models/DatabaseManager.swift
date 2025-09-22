//
//  DatabaseManager.swift
//  WeatherAppCWK
//
//  Created by Asel Inuke Hidallearachchi on 2024-12-21.
//

import Foundation
import SwiftData

class DatabaseManager {
    
    static let instance = DatabaseManager() // Shared singleton instance for global access
    
    // Core container responsible for managing data models
    let databaseContainer: ModelContainer
    
    private init() {
        do {
            // Initialize the database container with the `Location` model
            databaseContainer = try ModelContainer(for: Location.self)
            print("Database initialized successfully.")
        } catch {
            // Terminate the app if the database fails to initialize
            fatalError("Error initializing database: \(error.localizedDescription)")
        }
    }
}
