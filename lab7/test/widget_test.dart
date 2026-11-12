import 'package:bossleveldestini/brain.dart';
import 'package:bossleveldestini/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final width in [320.0, 1024.0]) {
    testWidgets('Shows all endings and restarts at width $width', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(Size(width, 600));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(const MainApp());

      for (final path in [
        [1, 1],
        [1, 2],
        [2, 2],
        [2, 1, 1],
      ]) {
        final story = StoryBrain();
        expect(find.text(story.getStory()), findsOneWidget);

        for (final choice in path) {
          final label = choice == 1 ? story.getchoose1() : story.getchoose2();
          final button = find.widgetWithText(OutlinedButton, label);
          await tester.ensureVisible(button);
          await tester.tap(button);
          await tester.pumpAndSettle();
          story.nextStory(choice);
          expect(find.text(story.getStory()), findsOneWidget);
        }

        expect(find.byType(OutlinedButton), findsOneWidget);
        final replay = find.widgetWithText(OutlinedButton, 'Chơi lại');
        await tester.ensureVisible(replay);
        await tester.tap(replay);
        await tester.pumpAndSettle();
      }

      expect(find.text(StoryBrain().getStory()), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
