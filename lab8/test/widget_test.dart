import 'package:bmical/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final width in [320.0, 1024.0]) {
    testWidgets('Calculates BMI and retains inputs at width $width', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(Size(width, 600));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(const BMICalculator());

      final increase = find.byTooltip('Tăng cân nặng');
      await tester.ensureVisible(increase);
      await tester.tap(increase);
      await tester.pumpAndSettle();

      final calculate = find.text('Tính chỉ số BMI');
      await tester.ensureVisible(calculate);
      await tester.tap(calculate);
      await tester.pumpAndSettle();

      expect(find.text('18.8'), findsOneWidget);
      expect(find.text('Bình thường'), findsOneWidget);
      expect(find.text('180 cm · 61 kg'), findsOneWidget);

      await tester.tap(find.text('Sửa số đo'));
      await tester.pumpAndSettle();
      expect(find.text('Tính BMI'), findsOneWidget);
      expect(find.text('61 kg', findRichText: true), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
