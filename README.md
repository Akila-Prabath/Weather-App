# SkyCast ☁️🌤️

A modern Flutter weather application that provides real-time weather information, location-based forecasts, and a beautiful user interface with dynamic weather visuals.

## 📱 Features

### Current Weather

* Real-time weather data
* Current temperature
* Weather condition description
* Humidity
* Wind speed
* Atmospheric pressure
* Feels-like temperature

### Forecast

* Today's hourly forecast
* Tomorrow's forecast
* 5-day weather forecast
* Detailed forecast report page

### Location Services

* Search weather by city name
* Current location weather
* Automatic location detection

### User Experience

* Modern gradient UI
* Custom weather illustrations
* Native splash screen
* Responsive design
* Pull-to-refresh support

## 🛠️ Built With

* Flutter
* Dart
* Riverpod
* Dio
* OpenWeatherMap API
* Geolocator
* Intl

## 📂 Project Structure

```text
lib/
├── core/
│   ├── constants/
│   ├── location/
│   ├── network/
│   └── utils/
│
├── features/
│   ├── splash/
│   └── weather/
│       ├── data/
│       ├── domain/
│       └── presentation/
│
└── main.dart
```

## 📸 Screenshots

<img width="1672" height="941" alt="ChatGPT Image Jun 20, 2026, 10_22_26 PM" src="https://github.com/user-attachments/assets/ce1b9b36-ac6e-439f-9597-d06fb9fa5a2e" />



## 🚀 Getting Started

### Prerequisites

* Flutter SDK
* Android Studio
* VS Code
* OpenWeatherMap API Key

### Installation

Clone the repository:

```bash
git clone https://github.com/Akila-Prabath/Weather-App.git
```

Navigate to the project:

```bash
cd Weather-App
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

## 🔑 Environment Setup

Create an API key from OpenWeatherMap and configure it inside:

```text
lib/core/constants/api_constants.dart
```

Example:

```dart
static const String apiKey = 'YOUR_API_KEY';
```
## 📥 Download APK

Download the latest SkyCast Android application from the Releases page:

👉 [Download SkyCast APK](../../releases/latest)

### Supported Architecture

* ARM64 (Recommended for modern Android devices)
* Android 8.0+

Current Release:

* SkyCast v1.0.0

## 🎯 Future Improvements

* Dynamic weather backgrounds
* Favorite cities
* Weather alerts
* Air quality information
* Dark/Light theme support
* Weather map integration

## 👨‍💻 Developer

**Akila Prabath**

Bachelor of Computing (Hons) in Software Engineering
University of Sri Jayewardenepura

## 📄 License

This project is created for educational and portfolio purposes.

