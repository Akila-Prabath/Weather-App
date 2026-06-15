import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../providers/weather_provider.dart';

class WeatherPage extends ConsumerWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final city = ref.watch(cityProvider);

    final weatherAsync = ref.watch(weatherProvider(city));

    final forecastAsync = ref.watch(forecastProvider(city));

    final cityController = TextEditingController();

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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 1, 17, 22),
              Color.fromARGB(255, 10, 61, 80),
              Color.fromARGB(255, 28, 123, 147),
            ],
          ),
        ),

        child: SafeArea(
          bottom: false,
          child: weatherAsync.when(
            loading: () => const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),

            error: (error, stack) => Center(
              child: Text(
                error.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),

            data: (weather) {
              final currentDate = DateFormat(
                'EEEE, d MMM',
              ).format(DateTime.now());

              return LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            const SizedBox(height: 30),

                            // Search Bar
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextField(
                                controller: cityController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Search City',
                                  hintStyle: const TextStyle(
                                    color: Colors.white70,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Colors.white70,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      final cityName = cityController.text
                                          .trim();

                                      if (cityName.isNotEmpty) {
                                        ref
                                            .read(cityProvider.notifier)
                                            .setCity(cityName);
                                      }
                                    },
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),

                            const SizedBox(height: 40),

                            Text(
                              currentDate,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                letterSpacing: 1,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              weather.cityName,
                              style: const TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(height: 20),

                            Image.network(
                              'https://openweathermap.org/img/wn/${weather.iconCode}@4x.png',
                              width: 160,
                              height: 160,
                            ),

                            Text(
                              '${weather.temperature.toStringAsFixed(1)}°',
                              style: const TextStyle(
                                fontSize: 82,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                                height: 1,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              weather.description.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                letterSpacing: 2,
                              ),
                            ),

                            const SizedBox(height: 30),

                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: 24,
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(28),
                                border: Border.all(color: Colors.white10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                      const SizedBox(height: 6),
                                      Text(
                                        '${weather.humidity}%',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 30),

                                      forecastAsync.when(
                                        loading: () =>
                                            const CircularProgressIndicator(),

                                        error: (e, _) => Text(
                                          e.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),

                                        data: (forecasts) {
                                          return Text(
                                            'Forecast Items: ${forecasts.length}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),

                                  Container(
                                    width: 1,
                                    height: 70,
                                    color: Colors.white12,
                                  ),

                                  Column(
                                    children: [
                                      const Icon(
                                        Icons.air,
                                        color: Colors.white70,
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'Wind',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        '${weather.windSpeed.toStringAsFixed(1)} m/s',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
