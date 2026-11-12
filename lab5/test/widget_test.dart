import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xylophone/main.dart';
import 'package:xylophone/xylophone_button.dart';

void main() {
  testWidgets('Shows seven playable keys on a narrow screen', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 568));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MainApp());

    expect(find.text('Xylophone'), findsOneWidget);
    expect(find.byType(XylophoneButton), findsNWidgets(7));
    for (final note in ['Đô', 'Rê', 'Mi', 'Fa', 'Sol', 'La', 'Si']) {
      expect(find.widgetWithText(XylophoneButton, note), findsOneWidget);
    }
    expect(tester.takeException(), isNull);
  });
}
