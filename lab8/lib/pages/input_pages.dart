import 'package:bmical/bmi_model.dart';
import 'package:bmical/components/bottom_btn.dart';
import 'package:bmical/components/card.dart';
import 'package:bmical/components/round_icon_btn.dart';
import 'package:bmical/constants.dart';
import 'package:bmical/pages/output_pages.dart';
import 'package:flutter/material.dart';

enum Gender { male, female }

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender? _gender;
  int _height = 180;
  int _weight = 60;
  int _age = 20;

  void _calculate() {
    final calculator = CalculatorBrain(height: _height, weight: _weight);
    final bmi = calculator.calculateBMI();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder:
            (context) => ResultsPage(
              bmiResult: bmi,
              resultText: calculator.getResult(),
              height: _height,
              weight: _weight,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Tính BMI', style: kTitleTextStyle),
                  const SizedBox(height: 8),
                  const Text(
                    'Nhập chiều cao và cân nặng để xem chỉ số BMI.',
                    style: kLabelTextStyle,
                  ),
                  const SizedBox(height: 24),
                  CardContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Giới tính', style: kLabelTextStyle),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final (gender, label, icon) in [
                              (Gender.male, 'Nam', Icons.male),
                              (Gender.female, 'Nữ', Icons.female),
                            ])
                              ChoiceChip(
                                label: Text(label),
                                avatar: Icon(icon, size: 20),
                                selected: _gender == gender,
                                onSelected:
                                    (selected) => setState(
                                      () => _gender = selected ? gender : null,
                                    ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  CardContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Chiều cao', style: kLabelTextStyle),
                        const SizedBox(height: 6),
                        Text('$_height cm', style: kNumberTextStyle),
                        Slider(
                          value: _height.toDouble(),
                          min: 120,
                          max: 220,
                          activeColor: kAccent,
                          semanticFormatterCallback:
                              (value) => '${value.round()} cm',
                          onChanged:
                              (value) =>
                                  setState(() => _height = value.round()),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('120 cm', style: kLabelTextStyle),
                            Text('220 cm', style: kLabelTextStyle),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _MeasureCard(
                          label: 'Cân nặng',
                          unit: 'kg',
                          value: _weight,
                          onDecrement:
                              _weight > 1
                                  ? () => setState(() => _weight--)
                                  : null,
                          onIncrement: () => setState(() => _weight++),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _MeasureCard(
                          label: 'Tuổi',
                          unit: 'tuổi',
                          value: _age,
                          onDecrement:
                              _age > 1 ? () => setState(() => _age--) : null,
                          onIncrement: () => setState(() => _age++),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  BottomButton(
                    onTap: _calculate,
                    buttonTitle: 'Tính chỉ số BMI',
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

class _MeasureCard extends StatelessWidget {
  const _MeasureCard({
    required this.label,
    required this.unit,
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
  });

  final String label;
  final String unit;
  final int value;
  final VoidCallback? onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: kLabelTextStyle),
          const SizedBox(height: 6),
          Text.rich(
            TextSpan(
              text: '$value',
              style: kNumberTextStyle,
              children: [TextSpan(text: ' $unit', style: kLabelTextStyle)],
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              RoundIconButton(
                icon: Icons.remove,
                tooltip: 'Giảm ${label.toLowerCase()}',
                onPressed: onDecrement,
              ),
              RoundIconButton(
                icon: Icons.add,
                tooltip: 'Tăng ${label.toLowerCase()}',
                onPressed: onIncrement,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
