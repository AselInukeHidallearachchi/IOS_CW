//
//  TouristAttractionModel.swift
//  WeatherAppCWK
//
//  Created by Asel Inuke Hidallearachchi on 2024-12-21.
//

import Foundation
import CoreLocation

// Represents a tourist attraction or place of interest.
struct TouristAttraction: Identifiable {
    let id = UUID()
    let name: String  
    let coordinate: CLLocationCoordinate2D  //  coordinates (latitude and longitude).
    let address: String
}
