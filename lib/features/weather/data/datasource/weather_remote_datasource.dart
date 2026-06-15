import 'package:dio/dio.dart';
import '../models/forecast_model.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/weather_model.dart';

class WeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSource(this.dio);

  Future<WeatherModel> getCurrentWeather(String city) async {
    final response = await dio.get(
      '${ApiConstants.baseUrl}/weather',
      queryParameters: {
        'q': city,
        'appid': ApiConstants.apiKey,
        'units': 'metric',
      },
    );

    return WeatherModel.fromJson(response.data);
  }

  Future<List<ForecastModel>> getForecast(String city) async {
    final response = await dio.get(
      '${ApiConstants.baseUrl}/forecast',
      queryParameters: {
        'q': city,
        'appid': ApiConstants.apiKey,
        'units': 'metric',
      },
    );

    final List forecasts = response.data['list'];

    return forecasts.map((json) => ForecastModel.fromJson(json)).toList();
  }
}
