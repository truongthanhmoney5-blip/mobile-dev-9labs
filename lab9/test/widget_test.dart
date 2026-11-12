import 'package:clima/theme_provider.dart';
import 'package:clima/weather_screen.dart';
import 'package:clima/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Shows Da Nang weather in the original layout', (tester) async {
    final client = MockClient((request) async {
      expect(request.url.host, 'api.open-meteo.com');
      expect(request.url.queryParameters['latitude'], '16.0642');
      expect(request.url.queryParameters['longitude'], '108.2190');
      return http.Response(
        '{"current":{"temperature_2m":28.4,"weather_code":3}}',
        200,
      );
    });
    addTearDown(client.close);

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(disableAnimations: true),
            child: WeatherScreen(
              weatherService: WeatherService(client: client),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('MINI WEATHER'), findsOneWidget);
    expect(find.text('ĐÀ NẴNG'), findsOneWidget);
    expect(find.text('28°C'), findsOneWidget);
    expect(find.text('Clouds'), findsOneWidget);
    expect(find.byType(Switch), findsOneWidget);
  });
}
