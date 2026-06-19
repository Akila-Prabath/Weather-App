import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasource/weather_remote_datasource.dart';
import '../../data/repository/weather_repository_impl.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/entities/forecast_entity.dart';
import '../../../../core/location/location_provider.dart';

/// Remote Data Source
final weatherRemoteDataSourceProvider =
    Provider<WeatherRemoteDataSource>((ref) {
  return WeatherRemoteDataSource(
    ref.read(dioProvider),
  );
});

/// Repository
final weatherRepositoryProvider =
    Provider<WeatherRepositoryImpl>((ref) {
  return WeatherRepositoryImpl(
    ref.read(weatherRemoteDataSourceProvider),
  );
});

/// Selected City
class CityNotifier extends Notifier<String> {
  @override
  String build() {
    return 'Colombo';
  }

  void setCity(String city) {
    state = city;
  }
}

final cityProvider =
    NotifierProvider<CityNotifier, String>(
  CityNotifier.new,
);

/// Weather Data
final weatherProvider =
    FutureProvider.family<WeatherEntity, String>(
  (ref, city) async {
    return ref
        .read(weatherRepositoryProvider)
        .getCurrentWeather(city);
  },
);

final forecastProvider =
    FutureProvider.family<
        List<ForecastEntity>,
        String>(
  (ref, city) async {
    return ref
        .read(weatherRepositoryProvider)
        .getForecast(city);
  },
);

class ForecastTabNotifier
    extends Notifier<int> {
  @override
  int build() => 0;

  void changeTab(int index) {
    state = index;
  }
}

final forecastTabProvider =
    NotifierProvider<
        ForecastTabNotifier,
        int>(
  ForecastTabNotifier.new,
);

final locationWeatherProvider =
    FutureProvider<
        WeatherEntity>((ref) async {
  final locationService =
      ref.read(
    locationServiceProvider,
  );

  final position =
      await locationService
          .getCurrentLocation();

  return ref
      .read(weatherRepositoryProvider)
      .getCurrentWeatherByLocation(
        position.latitude,
        position.longitude,
      );
});