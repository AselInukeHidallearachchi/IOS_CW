//
//  WeatherDataModel.swift
//  WeatherAppCWK
//
//  Created by Asel Inuke Hidallearachchi on 2024-12-21.
//

import Foundation

// MARK: - WeatherDataModel

struct WeatherDataModel: Codable {
    let lat: Double  // Latitude of the location.
    let lon: Double  // Longitude of the location.
    let timezone: String  // Timezone of the location (e.g., "Europe/London").
    let timezoneOffset: Int  // Timezone offset in seconds.
    let current: CurrentWeather  // Current weather data.
    let minutely: [MinutelyWeather]?  // Weather data for each minute (optional).
    let hourly: [HourlyWeather]  // Hourly weather forecast.
    let daily: [DailyWeather]  // Daily weather forecast.

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, minutely, hourly, daily
    }
}

// MARK: - Coord
// geographical coordinates (latitude and longitude).
struct Coord: Codable {
    let lon: Double  // Longitude of the location.
    let lat: Double  // Latitude of the location.
}

// MARK: - CurrentWeather
// Represents the current weather conditions.
struct CurrentWeather: Codable {
    let dt: Int  // Data timestamp (Unix format).
    let sunrise: Int  // Sunrise time (Unix format).
    let sunset: Int  // Sunset time (Unix format).
    let temp: Double  // Current temperature.
    let feelsLike: Double  // Feels-like temperature.
    let pressure: Int  // Atmospheric pressure in hPa.
    let humidity: Int  // Humidity in percentage.
    let dewPoint: Double  // Dew point temperature.
    let uvi: Double  // UV index.
    let clouds: Int  // Cloudiness in percentage.
    let visibility: Int  // Visibility in meters.
    let windSpeed: Double  // Wind speed in meters per second.
    let windDeg: Int  // Wind direction in degrees.
    let windGust: Double?  // Wind gust speed (optional).
    let weather: [Weather]  // Array of weather condition details.

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather
    }
}

// MARK: - HourlyWeather

struct HourlyWeather: Codable, Identifiable {
    let id = UUID()  // Unique identifier for SwiftUI's `ForEach`.
    let dt: Int  // Data timestamp (Unix format).
    let temp: Double  // Hourly temperature.
    let feelsLike: Double  // Feels-like temperature.
    let pressure: Int  // Atmospheric pressure in hPa.
    let humidity: Int  // Humidity in percentage.
    let dewPoint: Double  // Dew point temperature.
    let uvi: Double  // UV index.
    let clouds: Int  // Cloudiness in percentage.
    let visibility: Int  // Visibility in meters.
    let windSpeed: Double  // Wind speed in meters per second.
    let windDeg: Int  // Wind direction in degrees.
    let windGust: Double?  // Wind gust speed (optional).
    let weather: [Weather]  // Array of weather condition details.
    let pop: Double  // Probability of precipitation.

    enum CodingKeys: String, CodingKey {
        case dt, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, pop
    }
}

// MARK: - DailyWeather

struct DailyWeather: Codable, Identifiable {
    let id = UUID()  // Unique identifier for SwiftUI's `ForEach`.
    let dt: Int  // Data timestamp (Unix format).
    let sunrise: Int  // Sunrise time (Unix format).
    let sunset: Int  // Sunset time (Unix format).
    let moonrise: Int  // Moonrise time (Unix format).
    let moonset: Int  // Moonset time (Unix format).
    let moonPhase: Double  // Moon phase.
    let temp: Temp  // Daily temperature details.
    let feelsLike: FeelsLike  // Feels-like temperature details.
    let pressure: Int  // Atmospheric pressure in hPa.
    let humidity: Int  // Humidity in percentage.
    let dewPoint: Double  // Dew point temperature.
    let windSpeed: Double  // Wind speed in meters per second.
    let windDeg: Int  // Wind direction in degrees.
    let windGust: Double  // Wind gust speed.
    let weather: [Weather]  // Array of weather condition details.
    let clouds: Int  // Cloudiness in percentage.
    let pop: Double  // Probability of precipitation.
    let rain: Double?  // Rain volume (optional).
    let snow: Double?  // Snow volume (optional).
    let uvi: Double  // UV index.

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, clouds, pop, rain, snow, uvi
    }
}

// MARK: - MinutelyWeather

struct MinutelyWeather: Codable, Identifiable {
    var id = UUID()  // Unique identifier for SwiftUI's `ForEach`.
    let dt: Int  // Data timestamp (Unix format).
    let precipitation: Double  // Precipitation volume in millimeters.
}


// Represents details about the weather condition.
struct Weather: Codable {
    let id: Int  // Weather condition ID.
    let main: String  // Main weather condition (e.g., "Clear").
    let description: String  // Description of the weather condition (e.g., "clear sky").
    let icon: String  // Icon ID for the weather condition.
}


// Represents temperature details for a day.
struct Temp: Codable {
    let day, min, max, night, eve, morn: Double  // Temperatures for different times of the day.
}


// Represents feels-like temperature details for a day.
struct FeelsLike: Codable {
    let day, night, eve, morn: Double  // Feels-like temperatures for different times of the day.
}


// Represents the air quality data fetched from the API.
struct AirQualityData: Codable {
    let list: [AirQualityDetails]  // List of air quality details for the location.
}


// Represents detailed air quality information.
struct AirQualityDetails: Codable {
    let main: AirQualityMain  // Overall air quality index.
    let components: AirQualityComponents  // Concentrations of different air pollutants.
}


// Represents the air quality index (AQI).
struct AirQualityMain: Codable {
    let aqi: Int  // AQI value.
}


// Represents concentrations of various air pollutants.
struct AirQualityComponents: Codable {
    let co: Double  // Carbon monoxide concentration.
    let no: Double  // Nitric oxide concentration.
    let no2: Double  // Nitrogen dioxide concentration.
    let o3: Double  // Ozone concentration.
    let so2: Double  // Sulfur dioxide concentration.
    let pm2_5: Double  // Fine particulate matter (PM2.5) concentration.
    let pm10: Double  // Coarse particulate matter (PM10) concentration.
    let nh3: Double  // Ammonia concentration.
}
