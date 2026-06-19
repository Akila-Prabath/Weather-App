import '../../domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.cityName,
    required super.temperature,
    required super.description,
    required super.iconCode,
    required super.humidity,
    required super.windSpeed,
    required super.pressure,
    required super.feelsLike,
    required super.visibility,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: (json['main']['temp'] as num).toDouble(),

      description: json['weather'][0]['description'],

      iconCode: json['weather'][0]['icon'],

      humidity: json['main']['humidity'],

      windSpeed: (json['wind']['speed'] as num).toDouble(),

      pressure: json['main']['pressure'],

      feelsLike: (json['main']['feels_like'] as num).toDouble(),

      visibility: json['visibility'],
    );
  }
}
