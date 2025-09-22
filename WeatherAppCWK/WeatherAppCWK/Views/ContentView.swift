//
//  ContentView.swift
//  WeatherAppCWK
//
//  Created by Asel Inuke Hidallearachchi on 2024-12-21.
//


import SwiftUI
import Network

struct ContentView: View {
    
    @AppStorage("selectedTab") private var selectedTab: String = "Now"
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                
                NowView()
                    .tabItem {
                        Label("Now", systemImage: "sun.max.fill")
                    }
                    .tag("Now")

                PlaceMapView()
                    .tabItem {
                        Label("Place Map", systemImage: "map.fill")
                    }
                    .tag("PlaceMap")
                
                
                StoredPlacesView()
                    .tabItem {
                        Label("Stored Places", systemImage: "globe")
                    }
                    .tag("StoredPlaces")
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(NetworkMonitor())
        .environmentObject(StoredPlacesViewModel(context: DatabaseManager.instance.databaseContainer.mainContext))
}
