//
//  TouristAttractionsViewModel.swift
//  WeatherAppCWK
//
//  Created by Asel Inuke Hidallearachchi on 2024-12-21.
//

import Foundation
import SwiftUI
import MapKit

// managing data related to tourist attractions.
class TouristAttractionsViewModel: ObservableObject {
    
    @Published var touristAttractions: [TouristAttraction] = [] 
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278),  // Default center set to London.
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)  // Default zoom level.
    )
    

    
    func fetchTouristAttractions() {
        //print("Fetching tourist places for region: \(region.center.latitude), \(region.center.longitude)")
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Tourist Attraction"
        request.region = region

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let error = error {
                print("Error fetching tourist attractions: \(error.localizedDescription)")
            } else if let mapItems = response?.mapItems {
                DispatchQueue.main.async {
                    self.touristAttractions = mapItems.prefix(5).map { mapItem in
                        TouristAttraction(
                            name: mapItem.name ?? "Unknown",
                            coordinate: mapItem.placemark.coordinate,
                            address: mapItem.placemark.title ?? "No Address"
                        )
                    }
                }
            }
        }
    }

    // Updates the map region and fetches tourist attractions in the updated region.
    func updateRegionAndFetchCityName(latitude: Double, longitude: Double) {
        region.center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        fetchTouristAttractions()
    }
}
