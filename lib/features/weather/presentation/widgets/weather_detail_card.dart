import 'package:flutter/material.dart';

class WeatherDetailCard
    extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const WeatherDetailCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(
      BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color:
            const Color.fromARGB(
          255,
          3,
          39,
          50,
        ),
        borderRadius:
            BorderRadius.circular(
          20,
        ),
        border: Border.all(
          color: Colors.white10,
        ),
      ),

      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.white70,
          ),

          const SizedBox(height: 10),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}