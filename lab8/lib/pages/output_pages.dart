import 'package:bmical/components/bottom_btn.dart';
import 'package:bmical/constants.dart';
import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({
    required this.bmiResult,
    required this.resultText,
    required this.height,
    required this.weight,
    super.key,
  });

  final String bmiResult;
  final String resultText;
  final int height;
  final int weight;

  @override
  Widget build(BuildContext context) {
    final category = switch (resultText) {
      'Underweight' => 'Thiếu cân',
      'Normal' => 'Bình thường',
      'Overweight' => 'Thừa cân',
      _ => resultText,
    };

    return Scaffold(
      appBar: AppBar(backgroundColor: kBackground),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Kết quả BMI', style: kTitleTextStyle),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF205953), Color(0xFF183A43)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category,
                          style: const TextStyle(
                            color: Color(0xFFD3EDE6),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          bmiResult,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 68,
                            height: 1,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -2,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          '$height cm · $weight kg',
                          style: const TextStyle(
                            color: Color(0xFFD3EDE6),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  BottomButton(
                    onTap: () => Navigator.pop(context),
                    buttonTitle: 'Sửa số đo',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
