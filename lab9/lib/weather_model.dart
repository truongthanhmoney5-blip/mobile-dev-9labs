class Weather {
  const Weather({required this.temperature, required this.code});

  final double temperature;
  final int code;

  factory Weather.fromJson(Map<String, dynamic> json) {
    final current = json['current'] as Map<String, dynamic>;
    return Weather(
      temperature: (current['temperature_2m'] as num).toDouble(),
      code: (current['weather_code'] as num).toInt(),
    );
  }

  (String, String?) get presentation => switch (code) {
    0 => ('Clear', 'sunny'),
    1 || 2 || 3 => ('Clouds', 'cloudy'),
    45 || 48 => ('Mist', 'cloudy'),
    51 || 53 || 55 || 56 || 57 => ('Drizzle', 'rainy'),
    61 || 63 || 65 || 66 || 67 => ('Rain', 'rainy'),
    80 || 81 || 82 => ('Rain', 'rainy'),
    71 || 73 || 75 || 77 || 85 || 86 => ('Snow', 'snowy'),
    95 || 96 || 99 => ('Thunderstorm', 'thunder'),
    _ => ('Unknown', null),
  };
}
