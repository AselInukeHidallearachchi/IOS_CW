//
//  AirQualityViewModel.swift
//  WeatherAppCWK
//
//  Created by Asel Inuke Hidallearachchi on 2024-12-21.
//

import Foundation


class AirQualityViewModel: ObservableObject {
    
    @Published var airQualityData: AirQualityDetails?
    @Published var errorMessage: String?
    
    
    private let apiKey = APIConstants.weatherAPIKey

    
    func fetchAirQuality(lat: Double, lon: Double) async {
        
        let urlString = "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(lat)&lon=\(lon)&units=metric&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }

        do {

            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(AirQualityData.self, from: data)  // Decode JSON into `AirQualityData` model
            //print("Air quality data decoded: \(decodedData)")


            DispatchQueue.main.async {
                self.airQualityData = decodedData.list.first  // Store the first element of the fetched air quality data
              
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Failed to load air quality data."
            }
        }
    }
}
