import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'features/weather/data/datasource/weather_remote_datasource.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final datasource =
      WeatherRemoteDataSource(Dio());

  try {
    final weather =
        await datasource.getCurrentWeather(
      'Colombo',
    );

    print(weather.cityName);
    print(weather.temperature);
  } catch (e) {
    print(e);
  }

  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Weather App'),
        ),
      ),
    ),
  );
}