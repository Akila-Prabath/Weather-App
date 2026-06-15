import 'package:flutter/material.dart';

class ForecastPage extends StatelessWidget {
  const ForecastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 17, 22),
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
              child: const Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
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
              Color.fromARGB(255, 1, 17, 22),
              Color.fromARGB(255, 10, 61, 80),
              Color.fromARGB(255, 28, 123, 147),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
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
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    HourlyForecastCard(
                      time: '12:00',
                      temp: '32°',
                      icon: '04d',
                      selected: true,
                    ),
                    HourlyForecastCard(
                      time: '13:00',
                      temp: '32°',
                      icon: '10d',
                    ),
                    HourlyForecastCard(
                      time: '14:00',
                      temp: '31°',
                      icon: '04d',
                    ),
                    HourlyForecastCard(
                      time: '15:00',
                      temp: '30°',
                      icon: '10d',
                    ),
                  ],
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
                child: ListView(
                  children: const [
                    ForecastDayCard(
                      day: 'Friday',
                      date: 'Jan, 05',
                      temp: '32°',
                      icon: '10d',
                    ),
                    ForecastDayCard(
                      day: 'Saturday',
                      date: 'Jan, 06',
                      temp: '30°',
                      icon: '04d',
                    ),
                    ForecastDayCard(
                      day: 'Sunday',
                      date: 'Jan, 07',
                      temp: '29°',
                      icon: '09d',
                    ),
                    ForecastDayCard(
                      day: 'Monday',
                      date: 'Jan, 08',
                      temp: '31°',
                      icon: '10d',
                    ),
                  ],
                ),
              ),
            ],
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
            ? Color.fromARGB(255, 3, 39, 50)
            : Color.fromARGB(255, 3, 39, 50),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white10,
        ),
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),

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
        color: Color.fromARGB(255, 3, 39, 50),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.white10,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  day,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
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