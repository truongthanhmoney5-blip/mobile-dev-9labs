import 'package:eight_ball/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final width in [320.0, 1024.0]) {
    testWidgets('Shows and changes the answer at width $width', (tester) async {
      await tester.binding.setSurfaceSize(Size(width, 640));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(const EightBallApp());
      expect(find.text('Đang chờ câu hỏi'), findsOneWidget);

      final askButton = find.widgetWithText(FilledButton, 'Xem câu trả lời');
      await tester.ensureVisible(askButton);
      await tester.tap(askButton);
      await tester.pumpAndSettle();

      BallAnswer currentAnswer() => BallAnswer.values.singleWhere(
            (answer) => find.text(answer.label).evaluate().isNotEmpty,
          );

      final firstAnswer = currentAnswer();
      expect(find.image(AssetImage(firstAnswer.imagePath)), findsOneWidget);

      final ball = find.widgetWithImage(
        TextButton,
        AssetImage(firstAnswer.imagePath),
      );
      await tester.ensureVisible(ball);
      await tester.tap(ball);
      await tester.pumpAndSettle();

      final nextAnswer = currentAnswer();
      expect(nextAnswer, isNot(firstAnswer));
      expect(find.image(AssetImage(nextAnswer.imagePath)), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
