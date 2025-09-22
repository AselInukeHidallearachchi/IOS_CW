//
//  NowView.swift
//  WeatherAppCWK
//
//  Created by Asel Inuke Hidallearachchi on 2024-12-21.
//

import SwiftUI

struct NowView: View {
    // MARK: - State Objects
    @StateObject var weatherVM = WeatherViewModel()
    @StateObject var airQualityVM = AirQualityViewModel()
    
    // MARK: - AppStorage
    @AppStorage("latitude") var latitude: Double = 51.503377
    @AppStorage("longitude") var longitude: Double = -0.079518
    @AppStorage("currentCity") var currentCity: String = "London"
    
    // MARK: - State
    @State private var isLoading = true // Track loading state
    
    // MARK: - Current Date
    private var currentDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter.string(from: Date())
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            // MARK: - Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.6)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            if isLoading {
                ProgressView()
                    .scaleEffect(2.0)
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            } else {
                VStack {
                    // MARK: - Scrollable Content
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 20) {
                            // MARK: - Current Weather Section
                            if let current = weatherVM.currentWeather {
                                VStack(spacing: 5) {
                                    Text(weatherVM.cityName)
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    
                                    Text("\(current.temp, specifier: "%.0f")°")
                                        .font(.system(size: 80, weight: .thin))
                                        .foregroundColor(.white)
                                    
                                    Text(current.weather.first?.description.capitalized ?? "N/A")
                                        .font(.title3)
                                        .foregroundColor(.white.opacity(0.8))
                                    
                                    Text("H: \(weatherVM.tempMax)° L: \(weatherVM.tempMin)°")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.7))
                                }
                            }
                            
                            // MARK: - Hourly Forecast Section
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Hourly Forecast")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 20) {
                                        ForEach(weatherVM.hourlyWeatherUI) { hour in
                                            VStack(spacing: 8) {
                                                Text(hour.time)
                                                    .font(.caption)
                                                    .foregroundColor(.white)
                                                
                                                Image(systemName: "cloud.sun.fill")
                                                    .foregroundColor(.white)
                                                    .font(.title2)
                                                
                                                Text(hour.temperature)
                                                    .font(.body)
                                                    .foregroundColor(.white)
                                            }
                                            .frame(width: 80)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                            // MARK: - Daily Weather Section
                            VStack(alignment: .leading, spacing: 15) {
                                Text("7-Day Forecast")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                VStack(spacing: 10) {
                                    ForEach(weatherVM.dailyWeatherUI) { day in
                                        HStack {
                                            // Day of the week
                                            Text(day.day)
                                                .font(.body)
                                                .foregroundColor(.white)
                                                .frame(maxWidth: 60, alignment: .leading)
                                            
                                            Spacer()
                                            
                                            // Weather Icon
                                            Image(systemName: weatherIcon(for: day.description))
                                                .foregroundColor(.white)
                                                .font(.title3)
                                                .frame(maxWidth: .infinity, alignment: .center)
                                            
                                            Spacer()
                                            
                                            // Day and Night Temperatures
                                            VStack {
                                                Text("Day")
                                                    .font(.caption)
                                                    .foregroundColor(.white.opacity(0.7))
                                                Text("\(day.dayTemp)°")
                                                    .font(.body)
                                                    .foregroundColor(.white)
                                            }
                                            
                                            VStack {
                                                Text("Night")
                                                    .font(.caption)
                                                    .foregroundColor(.white.opacity(0.7))
                                                Text("\(day.nightTemp)°")
                                                    .font(.body)
                                                    .foregroundColor(.white)
                                            }
                                        }
                                        .padding(.vertical, 8)
                                    }
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.white.opacity(0.2))
                                )
                            }
                            .padding(.horizontal)
                            
                            // MARK: - Air Quality Section
                            if let airQuality = airQualityVM.airQualityData {
                                AirQualityView(airQuality: airQuality)
                                    .padding()
                            }
                        }
                        .padding()
                    }
                    Spacer()
                }
            }
        }
        .task {
            await fetchData()
        }
    }
    
    // MARK: - Helper Method for Icons
    private func weatherIcon(for description: String) -> String {
        switch description.lowercased() {
        case "light rain":
            return "cloud.rain.fill"
        case "moderate rain":
            return "cloud.heavyrain.fill"
        case "broken clouds":
            return "cloud.fog.fill"
        case "scattered clouds":
            return "cloud.fill"
        case "clear sky":
            return "sun.max.fill"
        case "few clouds":
            return "cloud.sun.fill"
        case "snow":
            return "cloud.snow.fill"
        case "thunderstorm":
            return "cloud.bolt.rain.fill"
        default:
            return "cloud.fill"
        }
    }
    
    // MARK: - Fetch Data
    private func fetchData() async {
        isLoading = true
        await weatherVM.fetchWeatherData(lat: latitude, lon: longitude)
        await airQualityVM.fetchAirQuality(lat: latitude, lon: longitude)
        isLoading = false
    }
}

#Preview {
    NowView()
}
