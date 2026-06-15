import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasource/weather_remote_datasource.dart';
import '../../data/repository/weather_repository_impl.dart';
import '../../domain/entities/weather_entity.dart';

final weatherRemoteDataSourceProvider =
    Provider<WeatherRemoteDataSource>((ref) {
  return WeatherRemoteDataSource(
    ref.read(dioProvider),
  );
});

final weatherRepositoryProvider =
    Provider<WeatherRepositoryImpl>((ref) {
  return WeatherRepositoryImpl(
    ref.read(
      weatherRemoteDataSourceProvider,
    ),
  );
});

final weatherProvider =
    FutureProvider.family<
        WeatherEntity,
        String>((ref, city) async {
  return ref
      .read(weatherRepositoryProvider)
      .getCurrentWeather(city);
});