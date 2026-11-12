import 'package:clima/theme_provider.dart';
import 'package:clima/weather_model.dart';
import 'package:clima/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({
    super.key,
    this.weatherService = const WeatherService(),
  });

  final WeatherService weatherService;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late final Future<Weather> _forecast;

  @override
  void initState() {
    super.initState();
    _forecast = widget.weatherService.getDaNangWeather();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MINI WEATHER',
          style: TextStyle(
            fontFamily: 'Georgia',
            letterSpacing: 2,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Icon(Icons.light_mode_outlined, size: 32),
                const SizedBox(width: 8),
                Switch(
                  value: themeProvider.isDarkMode,
                  onChanged: (_) => themeProvider.toggleTheme(),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.dark_mode_outlined, size: 32),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<Weather>(
          future: _forecast,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return const Text('Không tải được thời tiết Đà Nẵng.');
            }

            final weather = snapshot.requireData;
            final (condition, animation) = weather.presentation;
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'ĐÀ NẴNG',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      letterSpacing: 6,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Icon(Icons.location_on_outlined, size: 64),
                  if (animation != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Lottie.asset(
                        'assets/$animation.json',
                        animate: !MediaQuery.disableAnimationsOf(context),
                      ),
                    ),
                  Text(
                    condition,
                    style: const TextStyle(fontFamily: 'Georgia', fontSize: 32),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${weather.temperature.round()}°C',
                    style: const TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
