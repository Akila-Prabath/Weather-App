class WeatherImage {
  static String getImage(String iconCode) {
    switch (iconCode) {
      case '01d':
        return 'assets/weather/sunny.png';

      case '01n':
        return 'assets/weather/night_clear.png';

      case '02d':
      case '03d':
      case '04d':
        return 'assets/weather/cloudy.png';

      case '09d':
      case '10d':
      case '10n':
        return 'assets/weather/rainy.png';

      case '11d':
        return 'assets/weather/storm.png';

      case '13d':
        return 'assets/weather/snow.png';

      case '50d':
        return 'assets/weather/mist.png';

      default:
        return 'assets/weather/cloudy.png';
    }
  }
}