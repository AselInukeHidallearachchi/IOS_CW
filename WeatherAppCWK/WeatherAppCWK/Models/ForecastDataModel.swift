//
//  ForecastDataModel.swift
//  WeatherAppCWK
//
//  Created by Asel Inuke Hidallearachchi on 2024-12-21.
//

import Foundation

// Formats raw hourly weather data.
struct HourlyWeatherUI: Identifiable {
    let id = UUID()
    let time: String
    let temperature: String
    let icon: String

    init(hour: HourlyWeather) {
        self.time = DateFormatterUtils.formattedDate(from: hour.dt, format: "ha")  // 12-hour time format (e.g., "2PM").
        self.temperature = "\(Int(hour.temp))°C"
        self.icon = hour.weather.first?.icon ?? ""
    }
}

// Formats raw daily weather data.
struct DailyWeatherUI: Identifiable {
    let id = UUID()
    let day: String  // Formatted day and date (e.g., "Mon 21").
    let description: String
    let minTemp: String
    let maxTemp: String
    let dayTemp: String
    let nightTemp: String
    let icon: String

    init(day: DailyWeather) {
        self.day = DateFormatterUtils.formattedDate(from: day.dt, format: "EEE d")
        self.description = day.weather.first?.description ?? "N/A"
        self.minTemp = "\(Int(day.temp.min))"
        self.maxTemp = "\(Int(day.temp.max))"
        self.dayTemp = "\(Int(day.temp.day))"
        self.nightTemp = "\(Int(day.temp.night))"
        self.icon = day.weather.first?.icon ?? ""
    }
}
