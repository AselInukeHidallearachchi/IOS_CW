//
//  AirQualityView.swift
//  WeatherAppCWK
//
//  Created by Asel Inuke Hidallearachchi on 2025-01-06.
//

import SwiftUICore

struct AirQualityView: View {
    let airQuality: AirQualityDetails

    var body: some View {
        ZStack {
        
            VStack(spacing: 30) {
                // Title
                Text("Air Quality")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .padding(.top)

                // AQI Radial Gauge
                AirQualityRadialGauge(aqi: airQuality.main.aqi)

                // Health Impact Bar
                HealthImpactBar(aqi: airQuality.main.aqi)

                // Pollutants Grid
                VStack(spacing: 15) {
                    HStack(spacing: 15) {
                        PollutantCard(
                            title: "PM2.5",
                            value: String(format: "%.1f µg/m³", airQuality.components.pm2_5),
                            color: .blue,
                            icon: "aqi.medium"
                        )
                        PollutantCard(
                            title: "PM10",
                            value: String(format: "%.1f µg/m³", airQuality.components.pm10),
                            color: .green,
                            icon: "leaf.fill"
                        )
                    }
                    HStack(spacing: 15) {
                        PollutantCard(
                            title: "CO",
                            value: String(format: "%.1f µg/m³", airQuality.components.co),
                            color: .gray,
                            icon: "cloud.fill"
                        )
                        PollutantCard(
                            title: "O3",
                            value: String(format: "%.1f µg/m³", airQuality.components.o3),
                            color: .yellow,
                            icon: "sun.max.fill"
                        )
                    }
                    HStack(spacing: 15) {
                        PollutantCard(
                            title: "NO2",
                            value: String(format: "%.1f µg/m³", airQuality.components.no2),
                            color: .orange,
                            icon: "car.fill"
                        )
                        PollutantCard(
                            title: "SO2",
                            value: String(format: "%.1f µg/m³", airQuality.components.so2),
                            color: .red,
                            icon: "flame.fill"
                        )
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.white.opacity(0.2))
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 4)
            )
            .padding(.horizontal) 
        }
    }
}


struct HealthImpactBar: View {
    var aqi: Int

    var body: some View {
        HStack(spacing: 5) {
            ForEach(1...5, id: \.self) { level in
                Rectangle()
                    .fill(level <= aqi ? aqiColors(for: level).last! : Color.gray.opacity(0.3))
                    .frame(height: 10)
                    .cornerRadius(5)
            }
        }
        .animation(.easeInOut, value: aqi)
        .padding(.horizontal)
    }
}

struct PollutantCard: View {
    var title: String
    var value: String
    var color: Color
    var icon: String

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(color)
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            Text(value)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(width: 120, height: 150)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.1))
        )
        .shadow(color: color.opacity(0.6), radius: 10, x: 0, y: 4)
    }
}

struct AirQualityRadialGauge: View {
    var aqi: Int

    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .stroke(Color.white.opacity(0.2), lineWidth: 15)
                .frame(width: 200, height: 200)
            
            // Dynamic progress circle
            Circle()
                .trim(from: 0.0, to: CGFloat(aqi) / 5.0) // AQI scaled to range 1-5
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: aqiColors(for: aqi)),
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    style: StrokeStyle(lineWidth: 15, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .frame(width: 200, height: 200)
                .animation(.easeInOut(duration: 1), value: aqi)
            
            // AQI Value and Label
            VStack {
                Text("\(aqi)")
                    .font(.system(size: 50, weight: .bold))
                    .foregroundColor(.white)
                Text(aqiDescription(for: aqi))
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
    }
}
