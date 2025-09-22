//
//  StoredPlacesView.swift
//  WeatherAppCWK
//
//  Created by Asel Inuke Hidallearachchi on 2024-12-21.
//

import SwiftUI
import MapKit

struct StoredPlacesView: View {
    @EnvironmentObject var locationVM: StoredPlacesViewModel
    @AppStorage("selectedTab") private var selectedTab: String = "Now"
    @AppStorage("latitude") var latitude: Double = 51.5074
    @AppStorage("longitude") var longitude: Double = -0.1278
    @AppStorage("currentCity") var currentCity: String = "London"
    
    @State var cityName: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.blue.opacity(0.8),
                        Color.purple.opacity(0.7)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    
                    Text("Stored Places")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .padding(.top, 20)
                        .padding(.bottom, 30)
                    
                    
                    HStack {
                        TextField("Search for a city", text: $cityName, onCommit: {
                            searchCity()
                        })
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.1), radius: 5)
                        .font(.headline)
                        
                        Button(action: {
                            searchCity()
                        }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.2), radius: 5)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .edgesIgnoringSafeArea(.bottom)
                        
                        
                        if !locationVM.favoriteCities.isEmpty {
                            List {
                                ForEach(locationVM.favoriteCities) { city in
                                    HStack {
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text(city.name)
                                                .font(.headline)
                                                .foregroundColor(.black)
                                            Text("\(city.latitude), \(city.longitude)")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                        Button(action: {
                                            currentCity = city.name
                                            latitude = city.latitude
                                            longitude = city.longitude
                                            selectedTab = "Now"
                                        }) {
                                            Image(systemName: "location.fill")
                                                .foregroundColor(.green)
                                                .padding()
                                                .background(Color.white)
                                                .clipShape(Circle())
                                                .shadow(color: .black.opacity(0.2), radius: 5)
                                        }
                                    }
                                    .padding(.vertical, 6)
                                    .swipeActions(edge: .leading) {
                                        Button(role: .destructive) {
                                            // Remove city
                                            if let index = locationVM.favoriteCities.firstIndex(of: city) {
                                                locationVM.deleteCity(at: IndexSet(integer: index))
                                            }
                                        } label: {
                                            Label("Remove", systemImage: "star.slash.fill")
                                        }
                                        .tint(.red)
                                    }
                                }
                            }
                            
                            .scrollContentBackground(.hidden)
                            .listStyle(.plain)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        } else {
                            Text("No favorite places found.")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.top, 10)
                }
            }
            .navigationBarHidden(true)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Info"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    private func searchCity() {
        guard !cityName.isEmpty else {
            showAlert = true
            alertMessage = "Please enter a city name."
            return
        }
        
        // Validate cityName using regex
        let cityNameRegex = "^[a-zA-Z]+(?:[\\s-][a-zA-Z]+)*$"
        let isValidCityName = cityName.range(of: cityNameRegex, options: .regularExpression) != nil
        
        if !isValidCityName {
            showAlert = true
            alertMessage = "Invalid city name. Please enter a valid city name (e.g., New York, San Francisco)."
            cityName = ""
            return
        }
        
        // performs a search for the city and handles the result.
        locationVM.searchForCity(query: cityName) { result in
            switch result {
            case .success(let mapItem):
                if let name = mapItem.name, !name.isEmpty {
                    let coordinate = mapItem.placemark.coordinate
                    currentCity = name
                    latitude = coordinate.latitude
                    longitude = coordinate.longitude
                    cityName = ""
                    
                    // Automatically add to favorites
                    locationVM.addToFavorites(
                        name: currentCity,
                        latitude: latitude,
                        longitude: longitude
                    )
                    
                    showAlert = true
                    alertMessage = """
                    The location \(currentCity) \
                    (Lat: \(latitude), Lon: \(longitude)) \
                    has been added to your favorites.
                    """
                    selectedTab = "Now"
                } else {
                    handleInvalidLocation()
                }
                
            case .failure:
                handleInvalidLocation()
            }
        }
    }
    
    private func handleInvalidLocation() {
        showAlert = true
        alertMessage = "Location not found. Showing data for the previous location."
        cityName = ""
    }
    
    
}
