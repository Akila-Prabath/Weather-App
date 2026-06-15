import '../../domain/entities/weather_entity.dart';
import '../../domain/repository/weather_repository.dart';
import '../datasource/weather_remote_datasource.dart';

class WeatherRepositoryImpl
    implements WeatherRepository {

  final WeatherRemoteDataSource
      remoteDataSource;

  WeatherRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<WeatherEntity>
      getCurrentWeather(
    String city,
  ) async {
    return await remoteDataSource
        .getCurrentWeather(city);
  }
}