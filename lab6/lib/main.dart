import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'quiz_brain.dart';

const _pine = Color(0xFF183F36);
const _ink = Color(0xFF202D27);
const _muted = Color(0xFF53625A);
const _line = Color(0xFFDCE3D9);
const _correct = Color(0xFF22594B);
const _incorrect = Color(0xFF863F32);

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _pine),
        scaffoldBackgroundColor: const Color(0xFFF3F5EE),
        fontFamily: 'Roboto',
      ),
      home: const QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _quiz = QuizBrain();
  final _results = <bool>[];

  bool get _finished => _results.length == _quiz.questionCount;

  void _answer(bool choice) {
    if (_finished) return;
    setState(() {
      _results.add(choice == _quiz.getQuestionAnswer());
      _quiz.nextQuestion();
    });
  }

  void _restart() {
    setState(() {
      _results.clear();
      _quiz.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final total = _quiz.questionCount;
    final correctCount = _results.where((correct) => correct).length;
    final progressLabel =
        _finished ? 'Hoàn thành' : 'Câu ${_results.length + 1} / $total';

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, viewport) {
            const inset = 20.0;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(inset),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: math.max(0, viewport.maxHeight - inset * 2),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 640),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Semantics(
                            header: true,
                            child: const Text(
                              'Quizzler',
                              style: TextStyle(
                                color: _ink,
                                fontSize: 44,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -1.8,
                                height: 1.1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Đọc nhận định và chọn Đúng hoặc Sai.',
                            style: TextStyle(color: _muted, fontSize: 15),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            progressLabel,
                            style: const TextStyle(
                              color: _pine,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 9),
                          LinearProgressIndicator(
                            value: _results.length / total,
                            semanticsLabel: 'Tiến độ làm bài',
                            color: _correct,
                            backgroundColor: _line,
                            minHeight: 6,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          const SizedBox(height: 18),
                          _QuestionCard(
                            text:
                                _finished
                                    ? 'Bạn trả lời đúng $correctCount/$total câu.'
                                    : _quiz.getQuestionText(),
                          ),
                          const SizedBox(height: 16),
                          if (_finished)
                            FilledButton.icon(
                              onPressed: _restart,
                              icon: const Icon(Icons.refresh_rounded),
                              label: const Text('Chơi lại'),
                              style: FilledButton.styleFrom(
                                backgroundColor: _pine,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(0, 54),
                              ),
                            )
                          else
                            Row(
                              children: [
                                Expanded(
                                  child: _AnswerButton(
                                    label: 'Đúng',
                                    icon: Icons.check_rounded,
                                    foreground: _correct,
                                    background: const Color(0xFFE0EDE4),
                                    onPressed: () => _answer(true),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _AnswerButton(
                                    label: 'Sai',
                                    icon: Icons.close_rounded,
                                    foreground: _incorrect,
                                    background: const Color(0xFFF3E6DE),
                                    onPressed: () => _answer(false),
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 24),
                          Semantics(
                            liveRegion: true,
                            child: Text(
                              'Đã trả lời ${_results.length}/$total · $correctCount đúng',
                              style: const TextStyle(
                                color: _muted,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              for (var index = 0; index < total; index++)
                                _ResultDot(
                                  index: index,
                                  result:
                                      index < _results.length
                                          ? _results[index]
                                          : null,
                                ),
                            ],
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
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 208),
      padding: const EdgeInsets.all(28),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2B5346), _pine],
        ),
      ),
      child: Semantics(
        liveRegion: true,
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFFFAFCF4),
            fontSize: 26,
            fontWeight: FontWeight.w600,
            height: 1.3,
            letterSpacing: -0.4,
          ),
        ),
      ),
    );
  }
}

class _AnswerButton extends StatelessWidget {
  const _AnswerButton({
    required this.label,
    required this.icon,
    required this.foreground,
    required this.background,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final Color foreground;
  final Color background;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: FilledButton.styleFrom(
        minimumSize: const Size(0, 56),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: background,
        foregroundColor: foreground,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _ResultDot extends StatelessWidget {
  const _ResultDot({required this.index, required this.result});

  final int index;
  final bool? result;

  @override
  Widget build(BuildContext context) {
    final (color, icon, label) = switch (result) {
      true => (_correct, Icons.check_rounded, 'đúng'),
      false => (_incorrect, Icons.close_rounded, 'sai'),
      null => (_line, null, 'chưa trả lời'),
    };
    return Semantics(
      label: 'Câu ${index + 1}: $label',
      child: Container(
        width: 23,
        height: 23,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: icon == null ? null : Icon(icon, color: Colors.white, size: 15),
      ),
    );
  }
}
