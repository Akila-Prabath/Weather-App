import '../../domain/entities/weather_entity.dart';
import '../../domain/entities/forecast_entity.dart';
import '../../domain/repository/weather_repository.dart';
import '../datasource/weather_remote_datasource.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl(this.remoteDataSource);

  @override
  Future<WeatherEntity> getCurrentWeather(String city) async {
    return await remoteDataSource.getCurrentWeather(city);
  }

  @override
  Future<List<ForecastEntity>> getForecast(String city) async {
    return await remoteDataSource.getForecast(city);
  }

  Future<WeatherEntity> getCurrentWeatherByLocation(double lat, double lon) {
    return remoteDataSource.getCurrentWeatherByLocation(lat, lon);
  }
}
