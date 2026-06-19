import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../widgets/weather_detail_card.dart';
import '../providers/weather_provider.dart';
import 'forecast_page.dart';
import '../../domain/entities/forecast_entity.dart';

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
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.my_location,
                                          color: Colors.white70,
                                        ),
                                        onPressed: () async {
                                          // Next step
                                        },
                                      ),

                                      IconButton(
                                        icon: const Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          ref
                                                  .read(cityProvider.notifier)
                                                  .state =
                                              cityController.text;
                                        },
                                      ),
                                    ],
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
                            GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),

                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 1.5,

                              children: [
                                WeatherDetailCard(
                                  icon: Icons.water_drop,
                                  title: 'Humidity',
                                  value: '${weather.humidity}%',
                                ),

                                WeatherDetailCard(
                                  icon: Icons.air,
                                  title: 'Wind',
                                  value:
                                      '${weather.windSpeed.toStringAsFixed(1)} m/s',
                                ),

                                WeatherDetailCard(
                                  icon: Icons.speed,
                                  title: 'Pressure',
                                  value: '${weather.pressure} hPa',
                                ),

                                WeatherDetailCard(
                                  icon: Icons.thermostat,
                                  title: 'Feels Like',
                                  value:
                                      '${weather.feelsLike.toStringAsFixed(1)}°',
                                ),
                              ],
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
                                final selectedTab = ref.watch(
                                  forecastTabProvider,
                                );
                                final now = DateTime.now();

                                List<ForecastEntity> filteredForecasts = [];

                                if (selectedTab == 0) {
                                  // Today
                                  filteredForecasts = forecasts.where((
                                    forecast,
                                  ) {
                                    final date = DateTime.parse(forecast.time);

                                    return date.day == now.day &&
                                        date.month == now.month &&
                                        date.year == now.year;
                                  }).toList();
                                } else if (selectedTab == 1) {
                                  // Tomorrow
                                  final tomorrow = now.add(
                                    const Duration(days: 1),
                                  );

                                  filteredForecasts = forecasts.where((
                                    forecast,
                                  ) {
                                    final date = DateTime.parse(forecast.time);

                                    return date.day == tomorrow.day &&
                                        date.month == tomorrow.month &&
                                        date.year == tomorrow.year;
                                  }).toList();
                                } else {
                                  // Next 5 Days
                                  final addedDates = <String>{};

                                  final tomorrow = DateTime.now().add(
                                    const Duration(days: 1),
                                  );

                                  final tomorrowKey = DateFormat(
                                    'yyyy-MM-dd',
                                  ).format(tomorrow);

                                  filteredForecasts = forecasts
                                      .where((forecast) {
                                        final date = DateTime.parse(
                                          forecast.time,
                                        );

                                        final key = DateFormat(
                                          'yyyy-MM-dd',
                                        ).format(date);

                                        // Only start from tomorrow onwards
                                        if (date.isBefore(
                                          DateTime(
                                            tomorrow.year,
                                            tomorrow.month,
                                            tomorrow.day,
                                          ),
                                        )) {
                                          return false;
                                        }

                                        // One forecast per day
                                        if (addedDates.contains(key)) {
                                          return false;
                                        }

                                        addedDates.add(key);
                                        return true;
                                      })
                                      .take(5)
                                      .toList();
                                }
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
                                                    ForecastPage(city: city),
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
                                                '5 Days',
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
                                    selectedTab == 2
                                        ? SizedBox(
                                            height: 170,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  filteredForecasts.length > 5
                                                  ? 5
                                                  : filteredForecasts.length,
                                              itemBuilder: (context, index) {
                                                final forecast =
                                                    filteredForecasts[index];

                                                final date = DateTime.parse(
                                                  forecast.time,
                                                );

                                                return Container(
                                                  width: 120,
                                                  margin: const EdgeInsets.only(
                                                    right: 12,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.08),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          24,
                                                        ),
                                                    border: Border.all(
                                                      color: Colors.white10,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        DateFormat(
                                                          'EEE',
                                                        ).format(date),
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),

                                                      const SizedBox(height: 8),

                                                      Text(
                                                        DateFormat(
                                                          'MMM d',
                                                        ).format(date),
                                                        style: const TextStyle(
                                                          color: Colors.white70,
                                                        ),
                                                      ),

                                                      const SizedBox(
                                                        height: 10,
                                                      ),

                                                      Image.network(
                                                        'https://openweathermap.org/img/wn/${forecast.iconCode}@2x.png',
                                                        width: 60,
                                                      ),

                                                      const SizedBox(height: 8),

                                                      Text(
                                                        '${forecast.temperature.toStringAsFixed(0)}°',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        : SizedBox(
                                            height: 140,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  filteredForecasts.length > 8
                                                  ? 8
                                                  : filteredForecasts.length,
                                              itemBuilder: (context, index) {
                                                final forecast =
                                                    filteredForecasts[index];

                                                final time = DateTime.parse(
                                                  forecast.time,
                                                );

                                                return Container(
                                                  width: 100,
                                                  margin: const EdgeInsets.only(
                                                    right: 12,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.08),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          24,
                                                        ),
                                                    border: Border.all(
                                                      color: Colors.white10,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
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
                                                      ),

                                                      const SizedBox(height: 8),

                                                      Text(
                                                        '${forecast.temperature.toStringAsFixed(0)}°',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
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
