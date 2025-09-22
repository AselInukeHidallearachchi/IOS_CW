//
//  WeatherViewModel.swift
//  WeatherAppCWK
//
//  Created by Asel Inuke Hidallearachchi on 2024-12-21.
//

import Foundation

// managing weather data and preparing it for UI display.
class WeatherViewModel: ObservableObject {
    @Published var currentWeather: CurrentWeather?
    @Published var hourlyWeatherUI: [HourlyWeatherUI] = []
    @Published var dailyWeatherUI: [DailyWeatherUI] = []
    @Published var timezone: String = "Unknown Location"  
    @Published var cityName: String = "Location"  // City name derived from the timezone.
    @Published var tempMin: String = "--"  // Mintemperature for the current day.
    @Published var tempMax: String = "--"  // Max temperature for the current day.

    // Fetches weather data for a given latitude and longitude.
    func fetchWeatherData(lat: Double, lon: Double) async {
        
        let apiKey = APIConstants.weatherAPIKey
        
        let urlString = "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,alerts&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(WeatherDataModel.self, from: data)
            //print("Weather data decoded: \(decodedData)")

           
                self.tempMin = "\(Int(decodedData.daily.first?.temp.min ?? 0))"
                self.tempMax = "\(Int(decodedData.daily.first?.temp.max ?? 0))"
                self.currentWeather = decodedData.current
                self.timezone = decodedData.timezone
                self.cityName = self.extractLocationName(from: decodedData.timezone)
                self.hourlyWeatherUI = decodedData.hourly.map { HourlyWeatherUI(hour: $0) }
                self.dailyWeatherUI = decodedData.daily.map { DailyWeatherUI(day: $0) }
            
        } catch {
            print("Error fetching weather data: \(error)")
        }
    }

    // Extracts the location name from a timezone string (Region/City).
    private func extractLocationName(from timezone: String) -> String {
        return timezone.components(separatedBy: "/").last ?? "Unknown City"
    }
}
