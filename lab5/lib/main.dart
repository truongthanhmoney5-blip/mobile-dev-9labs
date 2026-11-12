import 'package:flutter/material.dart';
import 'package:xylophone/home_screen.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xylophone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE7BE8D),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF10131B),
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}
