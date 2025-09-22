# WeatherApp CWK - iOS Weather Application

An elegant iOS weather application built with SwiftUI that provides comprehensive weather information, air quality data, and tourist attractions for any location worldwide.

<p align="center">
  <img src="https://github.com/user-attachments/assets/2e2d80be-49bf-4a63-b7ac-e8be57e6ba2f" width="25%" />
  <img src="https://github.com/user-attachments/assets/eed2c628-7e70-4622-9c33-b4529b07246e" width="23%" />
  <img src="https://github.com/user-attachments/assets/ed6d7b78-8af5-4e75-a6d2-f6963263cc57" width="22%" />
  <img src="https://github.com/user-attachments/assets/b4252232-a1e6-4195-ab83-9cee1121ef00" width="22%" />
</p>


## ✨ Features

### 🌤️ Weather Information
- **Current Weather**: Real-time temperature, weather conditions, and detailed metrics
- **Hourly Forecast**: 48-hour detailed weather forecast with temperature and conditions
- **7-Day Forecast**: Extended weekly weather outlook with high/low temperatures
- **Weather Details**: Humidity, pressure, wind speed, UV index, and visibility

### 🌬️ Air Quality Monitoring
- **AQI Display**: Visual air quality index with color-coded health indicators
- **Pollutant Breakdown**: Detailed information for PM2.5, PM10, CO, NO2, O3, SO2, and NH3
- **Health Impact**: Easy-to-understand air quality ratings (Good, Fair, Moderate, Poor, Hazardous)
- **Visual Gauges**: Beautiful radial progress indicators for air quality levels

### 🗺️ Location & Places
- **Current Location**: Automatic location detection and weather fetching
- **Search Locations**: Search and add weather for any city worldwide
- **Saved Places**: Store and manage favorite locations for quick access
- **Tourist Attractions**: Discover top 5 tourist attractions in any city with interactive map
- **Map Integration**: MapKit integration for location visualization

### 📱 User Experience
- **Modern UI**: Clean, intuitive SwiftUI interface with gradient backgrounds
- **Dark Mode Support**: Optimized for both light and dark appearance
- **Offline Indicator**: Network status monitoring with connection alerts
- **Persistent Storage**: Core Data integration for saved locations
- **Tab Navigation**: Easy navigation between Now, Map, and Saved Places

## 🏗️ Architecture

### MVVM Pattern
The app follows the Model-View-ViewModel (MVVM) architectural pattern:

- **Models**: Data structures for weather, air quality, and location data
- **ViewModels**: Business logic and data management (`WeatherViewModel`, `AirQualityViewModel`, `TouristAttractionsViewModel`, `StoredPlacesViewModel`)
- **Views**: SwiftUI components for user interface presentation

### Key Components

#### ViewModels
- `WeatherViewModel`: Manages weather data fetching and processing
- `AirQualityViewModel`: Handles air quality data and calculations
- `TouristAttractionsViewModel`: Manages tourist attractions and map data
- `StoredPlacesViewModel`: Handles saved locations with Core Data integration
- `NetworkViewModel`: Monitors network connectivity

#### Models
- `WeatherDataModel`: Comprehensive weather data structures
- `AirQualityData`: Air quality and pollutant information
- `TouristAttractionModel`: Tourist attraction data model
- `LocationModel`: Location data for saved places

#### Utilities
- `DateFormatterUtils`: Various date formatting utilities for weather data
- `AirQualityUtils`: Color schemes and descriptions for air quality levels
- `APIConstants`: Centralized API configuration

## 🛠️ Technologies Used

- **SwiftUI**: Modern declarative UI framework
- **MapKit**: Maps and location services
- **Core Data**: Local data persistence
- **Swift Data**: Modern data persistence (iOS 17+)
- **Combine**: Reactive programming for data binding
- **URLSession**: Network requests and API integration
- **Core Location**: Location services and GPS functionality

## 📋 Requirements

- iOS 18.2+
- Xcode 15.0+
- Swift 5.0+
- Active internet connection for weather data
- Location services enabled for current location features

## ⚙️ Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/AselInukeHidallearachchi/IOS_CW.git
cd IOS_CW
```

### 2. API Configuration
The app uses OpenWeatherMap API for weather and air quality data.

1. Sign up for a free API key at [OpenWeatherMap](https://openweathermap.org/api)
2. Open `WeatherAppCWK/WeatherAppCWK/Utilities/APIConstants.swift`
3. Replace the existing API key with your own:
```swift
struct APIConstants {
    static let weatherAPIKey = "YOUR_API_KEY_HERE"
}
```

> **⚠️ Security Note**: The current implementation stores the API key in source code. For production apps, consider using:
> - Environment variables
> - Secure configuration files
> - Server-side proxy for API calls

### 3. Open in Xcode
1. Open `WeatherAppCWK.xcodeproj` in Xcode
2. Select your development team in the project settings
3. Build and run the project on your device or simulator

### 4. Permissions
The app will request the following permissions:
- **Location Services**: For current location weather data
- **Network Access**: For fetching weather and map data

## 🎯 Usage

### Getting Weather Data
1. **Current Location**: Tap "Now" tab to view weather for your current location
2. **Search Cities**: Use "Stored Places" tab to search and add new cities
3. **Saved Locations**: Access your saved cities from the stored places list

### Viewing Air Quality
- Air quality information is automatically displayed on the "Now" tab
- View detailed pollutant breakdowns and health recommendations

### Exploring Tourist Attractions
1. Navigate to "Place Map" tab
2. View interactive map with top 5 tourist attractions
3. Attractions update automatically based on selected location

### Managing Locations
1. Search for cities in "Stored Places" tab
2. Tap the location icon to set as current location
3. Swipe left on saved places to delete them

## 🔧 Project Structure

```
WeatherAppCWK/
├── WeatherAppCWK/
│   ├── WeatherAppCWKApp.swift          # App entry point
│   ├── Views/                          # SwiftUI Views
│   │   ├── ContentView.swift           # Main tab view
│   │   ├── NowView.swift              # Current weather display
│   │   ├── PlaceMapView.swift         # Map and attractions
│   │   ├── StoredPlacesView.swift     # Saved locations
│   │   ├── AirQualityView.swift       # Air quality display
│   │   └── NetworkStatusCard.swift    # Network status indicator
│   ├── ViewModels/                     # Business Logic
│   │   ├── WeatherViewModel.swift
│   │   ├── AirQualityViewModel.swift
│   │   ├── TouristAttractionsViewModel.swift
│   │   ├── StoredPlacesViewModel.swift
│   │   └── NetworkViewModel.swift
│   ├── Models/                         # Data Models
│   │   ├── WeatherDataModel.swift
│   │   ├── TouristAttractionModel.swift
│   │   ├── LocationModel.swift
│   │   └── DatabaseManager.swift
│   └── Utilities/                      # Helper Classes
│       ├── DateFormatterUtils.swift
│       ├── AirQualityUtils.swift
│       └── APIConstants.swift
```

## 🎨 UI/UX Features

- **Gradient Backgrounds**: Beautiful blue-to-purple gradients throughout the app
- **Glassmorphism**: Semi-transparent cards with blur effects
- **Animated Gauges**: Smooth animations for air quality indicators
- **Responsive Design**: Adapts to different screen sizes and orientations
- **Intuitive Navigation**: Clear tab-based navigation with descriptive icons

## 🌐 API Integration

### OpenWeatherMap API Endpoints
- **Current Weather**: `api.openweathermap.org/data/3.0/onecall`
- **Air Quality**: `api.openweathermap.org/data/2.5/air_pollution`
- **Geocoding**: For location search and coordinate conversion

### MapKit Integration
- **Tourist Attractions**: Uses `MKLocalSearch` for finding nearby attractions
- **Interactive Maps**: Displays location markers and user interaction

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is created for educational purposes as part of a coursework assignment.
