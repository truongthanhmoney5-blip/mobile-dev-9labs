import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:bossleveldestini/brain.dart';

const _night = Color(0xFF151917);
const _paper = Color(0xFFF3ECE0);
const _ink = Color(0xFF252B26);
const _amber = Color(0xFFE7B784);
const _panel = Color(0xFF242C27);

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Destini',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _amber,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: _night,
        fontFamily: 'Roboto',
      ),
      home: const StoryPage(),
    );
  }
}

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final _story = StoryBrain();
  final _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _choose(int choice) {
    setState(() => _story.nextStory(choice));
    if (_scroll.hasClients) {
      _scroll.jumpTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEnding = !_story.buttonShouldBeVisible();

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Color(0xC0151917), BlendMode.srcOver),
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, viewport) {
              final wide = viewport.maxWidth >= 840;
              final inset = wide ? 32.0 : 18.0;
              final passage = _Passage(text: _story.getStory(), wide: wide);
              final choices = Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Semantics(
                    header: true,
                    child: Text(
                      isEnding ? 'Kết thúc' : 'Bạn sẽ làm gì?',
                      style: const TextStyle(
                        color: _amber,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _ChoiceButton(
                    text: isEnding ? 'Chơi lại' : _story.getchoose1(),
                    icon: isEnding ? Icons.replay_rounded : Icons.arrow_forward,
                    onPressed: () => _choose(1),
                  ),
                  if (!isEnding) ...[
                    const SizedBox(height: 10),
                    _ChoiceButton(
                      text: _story.getchoose2(),
                      icon: Icons.arrow_forward,
                      onPressed: () => _choose(2),
                    ),
                  ],
                ],
              );

              return SingleChildScrollView(
                controller: _scroll,
                padding: EdgeInsets.all(inset),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: math.max(0, viewport.maxHeight - 2 * inset),
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 980),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Semantics(
                            header: true,
                            child: Text(
                              'Destini',
                              style: TextStyle(
                                color: _paper,
                                fontSize: wide ? 72 : 52,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -2.5,
                                height: 1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Truyện tương tác',
                            style: TextStyle(
                              color: _amber,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                          SizedBox(height: wide ? 32 : 24),
                          if (wide)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 3, child: passage),
                                const SizedBox(width: 28),
                                Expanded(flex: 2, child: choices),
                              ],
                            )
                          else ...[
                            passage,
                            const SizedBox(height: 22),
                            choices,
                          ],
                        ],
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

class _Passage extends StatelessWidget {
  const _Passage({required this.text, required this.wide});

  final String text;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(wide ? 36 : 22),
      decoration: BoxDecoration(
        color: _paper,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x48000000),
            offset: Offset(0, 12),
            blurRadius: 26,
          ),
        ],
      ),
      child: Semantics(
        liveRegion: true,
        child: Text(
          text,
          style: TextStyle(color: _ink, fontSize: wide ? 22 : 18, height: 1.6),
        ),
      ),
    );
  }
}

class _ChoiceButton extends StatelessWidget {
  const _ChoiceButton({
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 58),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        backgroundColor: _panel,
        foregroundColor: _paper,
        side: const BorderSide(color: Color(0xFF556050)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(
          fontSize: 15,
          height: 1.4,
          fontWeight: FontWeight.w600,
        ),
      ),
      child: Row(
        children: [
          Expanded(child: Text(text)),
          const SizedBox(width: 12),
          Icon(icon, color: _amber, size: 19),
        ],
      ),
    );
  }
}
