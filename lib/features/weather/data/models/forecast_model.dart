import '../../domain/entities/forecast_entity.dart';

class ForecastModel extends ForecastEntity {
  const ForecastModel({
    required super.time,
    required super.temperature,
    required super.iconCode,
  });

  factory ForecastModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ForecastModel(
      time: json['dt_txt'],
      temperature:
          (json['main']['temp'] as num)
              .toDouble(),
      iconCode:
          json['weather'][0]['icon'],
    );
  }
}