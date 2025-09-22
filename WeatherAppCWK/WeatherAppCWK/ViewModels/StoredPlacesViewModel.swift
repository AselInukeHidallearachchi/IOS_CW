//
//  StoredPlacesViewModel.swift
//  WeatherAppCWK
//
//  Created by Asel Inuke Hidallearachchi on 2024-12-21.
//

import Foundation
import MapKit
import SwiftData

//managing stored places 
class StoredPlacesViewModel: ObservableObject {

    @Published var favoriteCities: [Location] = []  // List of favorite cities from the database.
    @Published var searchResults: [MKMapItem] = []  // Search results from MapKit.
    

    private var modelContext: ModelContext  // Context for managing database operations.
    
    init(context: ModelContext) {
        self.modelContext = context
        loadFavoriteCities()
    }
    
    // Fetches all favorite cities from the database.
    private func loadFavoriteCities() {
        if let fetchedCities = try? modelContext.fetch(FetchDescriptor<Location>()) {
            self.favoriteCities = fetchedCities
            //print("Fetched cities: \(fetchedCities)")
        } else {
            self.favoriteCities = []
        }
    }
    
    // Searches for a city using MapKit's local search API.
    func searchForCity(query: String, completion: @escaping (Result<MKMapItem, Error>) -> Void) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = query
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            if let error = error {
                completion(.failure(error))
            } else if let firstResult = response?.mapItems.first {
                DispatchQueue.main.async {
                    self.searchResults = response?.mapItems ?? []
                    completion(.success(firstResult))
                }
            } else {
                completion(.failure(NSError(domain: "NoResults", code: 404, userInfo: [NSLocalizedDescriptionKey: "City not found."])))
            }
        }
    }

    // Adds a city to the list of favorite cities.
    func addToFavorites(name: String, latitude: Double, longitude: Double) {
        let city = Location(name: name, latitude: latitude, longitude: longitude)
        if !favoriteCities.contains(where: { $0.name == name }) {
            modelContext.insert(city)
            try? modelContext.save()
            loadFavoriteCities()
        }
    }
    
    // Deletes a city from the list of favorite cities.
    func deleteCity(at offsets: IndexSet) {
        offsets.forEach { index in
            let city = favoriteCities[index]
            do {
                modelContext.delete(city)
                try modelContext.save()
            } catch {
                print("Failed to delete city: \(error)")
            }
        }
        loadFavoriteCities()
    }
}
