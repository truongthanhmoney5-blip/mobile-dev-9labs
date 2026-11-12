import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miapp/main.dart';

void main() {
  testWidgets('Shows the profile and copies both contact values', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 568));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final copied = <String>[];
    final messenger = tester.binding.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'Clipboard.setData') {
        copied.add((call.arguments as Map)['text'] as String);
      }
      return null;
    });
    addTearDown(
      () => messenger.setMockMethodCallHandler(SystemChannels.platform, null),
    );

    await tester.pumpWidget(const MiCard());
    expect(find.text('Nguyễn Việt\nTrường Thành'), findsOneWidget);
    expect(find.text('Get in touch'), findsOneWidget);

    for (final label in ['email', 'phone']) {
      final copyButton = find.byTooltip('Copy $label');
      await tester.ensureVisible(copyButton);
      await tester.tap(copyButton);
      await tester.pumpAndSettle();
    }
    expect(copied, ['thanhnvt.23it@vku.udn.vn', '0365 283 540']);
    expect(tester.takeException(), isNull);
  });
}
