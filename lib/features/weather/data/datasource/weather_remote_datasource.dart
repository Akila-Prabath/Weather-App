import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../models/weather_model.dart';

class WeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSource(this.dio);

  Future<WeatherModel> getCurrentWeather(
      String city) async {

    final response = await dio.get(
      '${ApiConstants.baseUrl}/weather',
      queryParameters: {
        'q': city,
        'appid': ApiConstants.apiKey,
        'units': 'metric',
      },
    );

    return WeatherModel.fromJson(
      response.data,
    );
  }
}