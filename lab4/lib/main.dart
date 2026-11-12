import 'dart:math';

import 'package:flutter/material.dart';

const _ink = Color(0xFF142237);
const _muted = Color(0xFF465970);
const _blue = Color(0xFF174BC5);

enum BallAnswer {
  yes(1, 'Có.'),
  no(2, 'Không.'),
  later(3, 'Hãy hỏi lại sau.'),
  definitely(4, 'Chắc chắn là có.'),
  unsure(5, 'Quả cầu cũng chưa biết.');

  const BallAnswer(this.imageNumber, this.label);

  final int imageNumber;
  final String label;

  String get imagePath => 'assets/images/ball$imageNumber.png';
}

void main() => runApp(const EightBallApp());

class EightBallApp extends StatelessWidget {
  const EightBallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Magic 8 Ball',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _blue),
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF1F5FC),
      ),
      home: const BallPage(),
    );
  }
}

class BallPage extends StatefulWidget {
  const BallPage({super.key});

  @override
  State<BallPage> createState() => _BallPageState();
}

class _BallPageState extends State<BallPage> {
  final _random = Random();
  BallAnswer? _answer;

  void _ask() {
    final answers = BallAnswer.values;
    final previousIndex = _answer?.index ?? answers.length - 1;
    final offset = _answer == null
        ? _random.nextInt(answers.length)
        : _random.nextInt(answers.length - 1);
    final nextIndex = (previousIndex + 1 + offset) % answers.length;
    setState(() => _answer = answers[nextIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, viewport) {
            const inset = 20.0;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(inset),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: max(0.0, viewport.maxHeight - 2 * inset),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 960),
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                        side: const BorderSide(color: Color(0xFFD9E2F1)),
                      ),
                      child: LayoutBuilder(
                        builder: (context, card) {
                          final wide = card.maxWidth >= 720;
                          final controls = Padding(
                            padding: EdgeInsets.all(wide ? 48 : 24),
                            child: _buildControls(wide),
                          );
                          final ball = _BallDisplay(
                            answer: _answer,
                            onPressed: _ask,
                          );
                          if (wide) {
                            return Row(
                              children: [
                                Expanded(child: controls),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      0,
                                      16,
                                      16,
                                      16,
                                    ),
                                    child: ball,
                                  ),
                                ),
                              ],
                            );
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  12,
                                  12,
                                  12,
                                  0,
                                ),
                                child: ball,
                              ),
                              controls,
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildControls(bool wide) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'MAGIC 8 BALL',
          style: TextStyle(
            color: _blue,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.4,
          ),
        ),
        const SizedBox(height: 12),
        Semantics(
          header: true,
          child: Text(
            'Hỏi quả cầu',
            style: TextStyle(
              color: _ink,
              fontSize: wide ? 56 : 38,
              fontWeight: FontWeight.w800,
              height: 1.05,
              letterSpacing: -1.5,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Nghĩ về một câu hỏi có thể trả lời bằng có hoặc không.',
          style: TextStyle(color: _muted, fontSize: 16, height: 1.5),
        ),
        const SizedBox(height: 24),
        Semantics(
          liveRegion: true,
          child: Text(
            _answer?.label ?? 'Đang chờ câu hỏi',
            style: const TextStyle(
              color: _ink,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: _ask,
          icon: const Icon(Icons.auto_awesome_rounded, size: 20),
          label: Text(_answer == null ? 'Xem câu trả lời' : 'Hỏi tiếp'),
          style: FilledButton.styleFrom(
            backgroundColor: _blue,
            minimumSize: const Size(0, 52),
            padding: const EdgeInsets.symmetric(horizontal: 22),
            textStyle: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}

class _BallDisplay extends StatelessWidget {
  const _BallDisplay({required this.answer, required this.onPressed});

  final BallAnswer? answer;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final duration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : const Duration(milliseconds: 220);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const RadialGradient(
          radius: 0.85,
          colors: [Color(0xFFF9FBFF), Color(0xFFC8DAFB)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(8),
                shape: const CircleBorder(),
              ),
              child: Semantics(
                label: 'Chạm quả cầu để xem câu trả lời',
                excludeSemantics: true,
                child: AspectRatio(
                  aspectRatio: 1373 / 1232,
                  child: AnimatedSwitcher(
                    duration: duration,
                    child: Stack(
                      key: ValueKey(answer),
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          (answer ?? BallAnswer.yes).imagePath,
                          fit: BoxFit.contain,
                        ),
                        if (answer == null)
                          const FractionallySizedBox(
                            alignment: Alignment(0.025, -0.09),
                            widthFactor: 0.37,
                            heightFactor: 0.412,
                            child: Center(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF7FAFF),
                                    shape: BoxShape.circle,
                                  ),
                                  child: FractionallySizedBox(
                                    widthFactor: 0.42,
                                    heightFactor: 0.66,
                                    child: FittedBox(
                                      child: Text(
                                        '8',
                                        style: TextStyle(
                                          color: _ink,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
