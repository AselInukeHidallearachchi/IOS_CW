//
//  PlaceMapView.swift
//  WeatherAppCWK
//
//  Created by Asel Inuke Hidallearachchi on 2024-12-21.
//

import SwiftUI
import MapKit

struct PlaceMapView: View {
    @StateObject private var viewModel = TouristAttractionsViewModel()
    @AppStorage("latitude") var latitude: Double = 51.5074
    @AppStorage("longitude") var longitude: Double = -0.1278
    @AppStorage("currentCity") var currentCity: String = "London"
    @State private var isLoading: Bool = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.6)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing:10) {
                    
                    Text("Map View")
                        .font(.title.bold())
                        .foregroundColor(.white)
                    
                    // Map Section
                    Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.touristAttractions) { place in
                        MapMarker(coordinate: place.coordinate, tint: .red)
                    }
                    .frame(height: 300)
                    .cornerRadius(10)
                    .overlay(
                        isLoading ? ProgressView().scaleEffect(1.5) : nil,
                        alignment: .center
                    )
                    .padding()
                    
                    Divider()
                        .background(Color.white.opacity(0.8))
                    
                    // Title Section
                    Text("Top 5 Tourist Attractions in \(currentCity)")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .padding(.bottom)
                    
                    // Tourist Places List
                    ScrollView {
                        ForEach(viewModel.touristAttractions) { place in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(place.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(place.address)
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                            .padding(.horizontal)
                        }
                    }
                }
                .padding()
                .onAppear {
                    isLoading = true
                    viewModel.updateRegionAndFetchCityName(latitude: latitude, longitude: longitude)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isLoading = false
                    }
                }
                
                // Internet Connection Warning
                if !NetworkMonitor().isConnected {
                    NetworkStatusCard()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    PlaceMapView()
}
