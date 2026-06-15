import 'package:flutter/material.dart';

class ForecastDayCard extends StatelessWidget {
  final String day;
  final String date;
  final String iconCode;
  final String temperature;

  const ForecastDayCard({
    super.key,
    required this.day,
    required this.date,
    required this.iconCode,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(
          0.08,
        ),
        borderRadius:
            BorderRadius.circular(24),
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
                  style:
                      const TextStyle(
                    color:
                        Colors.white,
                    fontSize: 20,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  date,
                  style:
                      const TextStyle(
                    color:
                        Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          Text(
            temperature,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
            ),
          ),

          const SizedBox(width: 20),

          Image.network(
            'https://openweathermap.org/img/wn/$iconCode@2x.png',
            width: 70,
          ),
        ],
      ),
    );
  }
}