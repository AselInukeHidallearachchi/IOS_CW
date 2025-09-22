//
//  AirQualityUtils.swift
//  WeatherAppCWK
//
//  Created by Asel Inuke Hidallearachchi on 2025-01-06.
//

import SwiftUI

func aqiColors(for aqi: Int) -> [Color] {
    switch aqi {
    case 1: return [Color.green, Color.green.opacity(0.7)]
    case 2: return [Color.yellow, Color.yellow.opacity(0.7)]
    case 3: return [Color.orange, Color.orange.opacity(0.7)]
    case 4: return [Color.red, Color.red.opacity(0.7)]
    case 5: return [Color.purple, Color.purple.opacity(0.7)]
    default: return [Color.gray, Color.gray.opacity(0.7)]
    }
}

func aqiDescription(for aqi: Int) -> String {
    switch aqi {
    case 1: return "Good"
    case 2: return "Fair"
    case 3: return "Moderate"
    case 4: return "Poor"
    case 5: return "Hazardous"
    default: return "Unknown"
    }
}
