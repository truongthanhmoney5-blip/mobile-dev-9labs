import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzler/main.dart';
import 'package:quizzler/quiz_brain.dart';

void main() {
  testWidgets('Scores the last answer and resets the quiz on mobile', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 568));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const Quizzler());
    final quiz = QuizBrain();
    final total = quiz.questionCount;

    for (var index = 0; index < total; index++) {
      expect(find.text('Câu ${index + 1} / $total'), findsOneWidget);
      final button = find.widgetWithText(
        FilledButton,
        quiz.getQuestionAnswer() ? 'Đúng' : 'Sai',
      );
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pumpAndSettle();
      quiz.nextQuestion();
    }

    expect(find.text('Bạn trả lời đúng $total/$total câu.'), findsOneWidget);
    final restart = find.widgetWithText(FilledButton, 'Chơi lại');
    await tester.ensureVisible(restart);
    await tester.tap(restart);
    await tester.pumpAndSettle();

    expect(find.text('Câu 1 / $total'), findsOneWidget);
    expect(find.text('Đã trả lời 0/$total · 0 đúng'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
