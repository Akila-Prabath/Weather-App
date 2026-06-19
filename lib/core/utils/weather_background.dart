import 'package:flutter/material.dart';

class WeatherBackground {
  static List<Color> getGradient(
    String description,
  ) {
    final weather =
        description.toLowerCase();

    if (weather.contains(
      'clear',
    )) {
      return [
        const Color(
          0xFF1A2980,
        ),
        const Color(
          0xFF26D0CE,
        ),
      ];
    }

    if (weather.contains(
      'cloud',
    )) {
      return [
        const Color(
          0xFF4B79A1,
        ),
        const Color(
          0xFF283E51,
        ),
      ];
    }

    if (weather.contains(
      'rain',
    )) {
      return [
        const Color(
          0xFF232526,
        ),
        const Color(
          0xFF414345,
        ),
      ];
    }

    return [
      const Color.fromARGB(
        255,
        1,
        17,
        22,
      ),
      const Color.fromARGB(
        255,
        10,
        61,
        80,
      ),
      const Color.fromARGB(
        255,
        28,
        123,
        147,
      ),
    ];
  }
}