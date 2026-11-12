import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:xylophone/button_model.dart';
import 'package:xylophone/xylophone_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.25,
            colors: [Color(0xFF292535), Color(0xFF10131B)],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, viewport) {
              const inset = 20.0;
              final keyHeight =
                  ((viewport.maxHeight - 242) / allButtons.length)
                      .clamp(46.0, 58.0)
                      .toDouble();

              return SingleChildScrollView(
                padding: const EdgeInsets.all(inset),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight:
                        (viewport.maxHeight - inset * 2)
                            .clamp(0.0, double.infinity)
                            .toDouble(),
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 520),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Semantics(
                              header: true,
                              child: const Text(
                                'Xylophone',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFFFF3E8),
                                  fontSize: 46,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -2,
                                  height: 1.05,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Chạm vào phím để chơi một nốt.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFC9BFCD),
                                fontSize: 15,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 24),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: const Color(0xFF191A25),
                                border: Border.all(
                                  color: const Color(0xFF393542),
                                ),
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x40000000),
                                    blurRadius: 28,
                                    offset: Offset(0, 14),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (final (index, key)
                                        in allButtons.indexed)
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: index == 0 ? 0 : 8,
                                        ),
                                        child: FractionallySizedBox(
                                          widthFactor: 1 - index * 0.045,
                                          child: SizedBox(
                                            height: keyHeight,
                                            child: XylophoneButton(
                                              note: key.note,
                                              color: key.color,
                                              onPressed: () {
                                                _player.play(
                                                  AssetSource(
                                                    '${key.audioName}.wav',
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
