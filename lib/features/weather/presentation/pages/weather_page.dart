import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../providers/weather_provider.dart';
import 'forecast_page.dart';

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
                            const SizedBox(height: 20),

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

                            const SizedBox(height: 20),

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
                              width: 120,
                              height: 120,
                            ),

                            Text(
                              '${weather.temperature.toStringAsFixed(1)}°',
                              style: const TextStyle(
                                fontSize: 68,
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

                            const SizedBox(height: 20),

                            // Weather Card
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

                            const SizedBox(height: 35),

                            // Forecast Section
                            forecastAsync.when(
                              loading: () => const CircularProgressIndicator(
                                color: Colors.white,
                              ),

                              error: (e, _) => Text(
                                e.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),

                              data: (forecasts) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Header
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Forecast',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),

                                        IconButton(
                                          icon: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    const ForecastPage(),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 10),

                                    // Tabs
                                    Consumer(
                                      builder: (context, ref, child) {
                                        final selectedTab = ref.watch(
                                          forecastTabProvider,
                                        );

                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              _forecastTab(
                                                ref,
                                                'Today',
                                                0,
                                                selectedTab,
                                              ),

                                              const SizedBox(width: 12),

                                              _forecastTab(
                                                ref,
                                                'Tomorrow',
                                                1,
                                                selectedTab,
                                              ),

                                              const SizedBox(width: 12),

                                              _forecastTab(
                                                ref,
                                                'Next 5 Days',
                                                2,
                                                selectedTab,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),

                                    const SizedBox(height: 20),

                                    // Hourly Forecast Cards
                                    SizedBox(
                                      height: 140,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: forecasts.length,

                                        itemBuilder: (context, index) {
                                          final forecast = forecasts[index];

                                          final time = DateTime.parse(
                                            forecast.time,
                                          );

                                          return Container(
                                            width: 100,
                                            margin: const EdgeInsets.only(
                                              right: 12,
                                            ),

                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(
                                                0.08,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                              border: Border.all(
                                                color: Colors.white10,
                                              ),
                                            ),

                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${time.hour}:00',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),

                                                const SizedBox(height: 8),

                                                Image.network(
                                                  'https://openweathermap.org/img/wn/${forecast.iconCode}@2x.png',
                                                  width: 50,
                                                  height: 50,
                                                ),

                                                const SizedBox(height: 8),

                                                Text(
                                                  '${forecast.temperature.toStringAsFixed(0)}°',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
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

  Widget _forecastTab(
    WidgetRef ref,
    String title,
    int index,
    int selectedIndex,
  ) {
    final isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: () {
        ref.read(forecastTabProvider.notifier).changeTab(index);
      },

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withOpacity(0.15)
              : Colors.transparent,

          borderRadius: BorderRadius.circular(16),
        ),

        child: Text(
          title,
          style: TextStyle(color: isSelected ? Colors.white : Colors.white70),
        ),
      ),
    );
  }
}
