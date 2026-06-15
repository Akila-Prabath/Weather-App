import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/weather_provider.dart';

class WeatherPage extends ConsumerWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherProvider('Colombo'));

    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Weather App'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,

      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF3B5BDB), Color(0xFF5C7CFA), Color(0xFF74C0FC)],
          ),
        ),
        child: Center(
          child: weatherAsync.when(
            loading: () => const CircularProgressIndicator(color: Colors.white),

            error: (error, stack) => Text(
              error.toString(),
              style: const TextStyle(color: Colors.white),
            ),

            data: (weather) {
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      weather.cityName,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Image.network(
                      'https://openweathermap.org/img/wn/${weather.iconCode}@4x.png',
                      width: 140,
                      height: 140,
                    ),

                    Text(
                      '${weather.temperature.toStringAsFixed(1)}°',
                      style: const TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      weather.description.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        letterSpacing: 1.5,
                      ),
                    ),

                    const SizedBox(height: 40),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 24,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Icon(
                                Icons.water_drop,
                                color: Colors.white70,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Humidity',
                                style: TextStyle(color: Colors.white70),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${weather.humidity}%',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          Container(
                            width: 1,
                            height: 60,
                            color: Colors.white24,
                          ),

                          Column(
                            children: [
                              const Icon(Icons.air, color: Colors.white70),
                              const SizedBox(height: 8),
                              const Text(
                                'Wind',
                                style: TextStyle(color: Colors.white70),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${weather.windSpeed.toStringAsFixed(1)} m/s',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
