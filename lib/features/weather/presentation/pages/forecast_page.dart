import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../providers/weather_provider.dart';

class ForecastPage extends ConsumerWidget {
  final String city;

  const ForecastPage({super.key, required this.city});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forecastAsync = ref.watch(forecastProvider(city));

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 12, 32),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: const Text('Forecast Report'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white.withOpacity(0.1),
              child: const Icon(Icons.more_horiz, color: Colors.white),
            ),
          ),
        ],
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 0, 74, 173),
              Color.fromARGB(255, 1, 28, 72),
              Color.fromARGB(255, 0, 12, 32),
            ],
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.all(20),
          child: forecastAsync.when(
            loading: () => const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),

            error: (e, _) => Center(
              child: Text(
                e.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),

            data: (forecasts) {
              final dailyForecasts = <dynamic>[];
              final addedDates = <String>{};

              final tomorrow = DateTime.now().add(const Duration(days: 1));

              final tomorrowDate = DateTime(
                tomorrow.year,
                tomorrow.month,
                tomorrow.day,
              );

              for (final forecast in forecasts) {
                final date = DateTime.parse(forecast.time);

                // Skip anything before tomorrow
                if (date.isBefore(tomorrowDate)) {
                  continue;
                }

                final dateKey = DateFormat('yyyy-MM-dd').format(date);

                // Keep only one forecast per day
                if (!addedDates.contains(dateKey)) {
                  addedDates.add(dateKey);
                  dailyForecasts.add(forecast);
                }

                // Stop after 5 days
                if (dailyForecasts.length == 5) {
                  break;
                }
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Today',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    height: 130,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: forecasts.length,
                      itemBuilder: (context, index) {
                        final forecast = forecasts[index];

                        final time = DateTime.parse(forecast.time);

                        return HourlyForecastCard(
                          time: DateFormat('HH:mm').format(time),

                          temp: '${forecast.temperature.toStringAsFixed(0)}°',

                          icon: forecast.iconCode,

                          selected: index == 0,
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Next Forecast',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Expanded(
                    child: ListView.builder(
                      itemCount: dailyForecasts.length,

                      itemBuilder: (context, index) {
                        final forecast = dailyForecasts[index];

                        final date = DateTime.parse(forecast.time);

                        return ForecastDayCard(
                          day: DateFormat('EEEE').format(date),

                          date: DateFormat('MMM d').format(date),

                          temp: '${forecast.temperature.toStringAsFixed(0)}°',

                          icon: forecast.iconCode,
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class HourlyForecastCard extends StatelessWidget {
  final String time;
  final String temp;
  final String icon;
  final bool selected;

  const HourlyForecastCard({
    super.key,
    required this.time,
    required this.temp,
    required this.icon,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: selected
            ? Colors.black.withOpacity(0.35)
            : Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time, style: const TextStyle(color: Colors.white)),

          const SizedBox(height: 8),

          Image.network(
            'https://openweathermap.org/img/wn/$icon@2x.png',
            width: 50,
          ),

          const SizedBox(height: 8),

          Text(
            temp,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ForecastDayCard extends StatelessWidget {
  final String day;
  final String date;
  final String temp;
  final String icon;

  const ForecastDayCard({
    super.key,
    required this.day,
    required this.date,
    required this.temp,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  day,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(date, style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),

          Text(
            temp,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w300,
            ),
          ),

          const SizedBox(width: 20),

          Image.network(
            'https://openweathermap.org/img/wn/$icon@2x.png',
            width: 70,
          ),
        ],
      ),
    );
  }
}
