import 'package:bmical/constants.dart';
import 'package:bmical/pages/input_pages.dart';
import 'package:flutter/material.dart';

void main() => runApp(const BMICalculator());

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tính BMI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kAccent),
        scaffoldBackgroundColor: kBackground,
        fontFamily: 'Roboto',
      ),
      home: const InputPage(),
    );
  }
}
