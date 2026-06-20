import 'package:flutter/material.dart';

class WeatherErrorWidget
    extends StatelessWidget {
  final VoidCallback onRetry;

  const WeatherErrorWidget({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_off,
              size: 80,
              color: Colors.white70,
            ),

            const SizedBox(
              height: 20,
            ),

            const Text(
              'Unable to load weather',
              textAlign:
                  TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            const Text(
              'Please check your internet connection and try again.',
              textAlign:
                  TextAlign.center,
              style: TextStyle(
                color:
                    Colors.white70,
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            ElevatedButton.icon(
              onPressed: onRetry,

              icon: const Icon(
                Icons.refresh,
              ),

              label: const Text(
                'Retry',
              ),
            ),
          ],
        ),
      ),
    );
  }
}