//
//  LocationModel.swift
//   WeatherAppCWK
//
//  Created by Asel Inuke Hidallearachchi on 2024-12-21.
//

import Foundation
import SwiftData

@Model
class Location {
    @Attribute(.unique) var id: UUID  // Ensures each Location has a unique identifier.
    var name: String
    var latitude: Double
    var longitude: Double

    init(name: String, latitude: Double, longitude: Double) {
        self.id = UUID()
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}

// Ensures `Location` instances can be compared based on their unique IDs.
extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id
    }
}
