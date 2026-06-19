class WeatherEntity {
  final String cityName;
  final double temperature;
  final String description;
  final String iconCode;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final double feelsLike;
  final int visibility;

  const WeatherEntity({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.iconCode,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.feelsLike,
    required this.visibility,
  });
}