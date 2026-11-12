import 'dart:convert';

import 'package:clima/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  const WeatherService({http.Client? client}) : _client = client;

  final http.Client? _client;

  Future<Weather> getDaNangWeather() async {
    final uri = Uri.https('api.open-meteo.com', '/v1/forecast', {
      'latitude': '16.0642',
      'longitude': '108.2190',
      'current': 'temperature_2m,weather_code',
      'temperature_unit': 'celsius',
    });
    final response = await (_client?.get(uri) ?? http.get(uri)).timeout(
      const Duration(seconds: 10),
    );
    if (response.statusCode != 200) {
      throw http.ClientException(
        'Weather API returned ${response.statusCode}',
        uri,
      );
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return Weather.fromJson(data);
  }
}
