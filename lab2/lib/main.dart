import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _ink = Color(0xFF162C33);
const _teal = Color(0xFF28685E);
const _muted = Color(0xFF56665F);
const _background = Color(0xFFF2F7F3);
const _email = 'thanhnvt.23it@vku.udn.vn';
const _phone = '0365 283 540';

void main() => runApp(const MiCard());

class MiCard extends StatelessWidget {
  const MiCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thành · AI Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _teal),
        scaffoldBackgroundColor: _background,
        fontFamily: 'Roboto',
      ),
      home: const _ProfilePage(),
    );
  }
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(14, 8, 14, 22),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x10214238),
                          blurRadius: 28,
                          offset: Offset(0, 12),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [_ProfileHeader(), _ContactSection()],
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Text("LET'S CONNECT", style: _eyebrow),
                  const SizedBox(height: 7),
                  const Text(
                    "Have an idea worth exploring? I’d love to hear from you.",
                    style: _supporting,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const _eyebrow = TextStyle(
  color: _teal,
  fontSize: 10,
  letterSpacing: 1.1,
  fontWeight: FontWeight.w700,
);
const _supporting = TextStyle(color: _muted, fontSize: 12, height: 1.5);

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFF132B32),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExcludeSemantics(
              child: Container(
                width: 64,
                height: 64,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFD6F0E5),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Text(
                  'TT',
                  style: TextStyle(
                    color: _teal,
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 38),
            const Text(
              'NICE TO MEET YOU',
              style: TextStyle(
                color: Color(0xFF9FD6CB),
                fontSize: 10,
                letterSpacing: 1.1,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Semantics(
              header: true,
              child: const Text(
                'Nguyễn Việt\nTrường Thành',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  height: 1.08,
                  letterSpacing: -0.7,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 11),
            const Text(
              'AI Developer',
              style: TextStyle(
                color: Color(0xFFC3DAD8),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactSection extends StatelessWidget {
  const _ContactSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 23, 22, 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            header: true,
            child: const Text(
              'Get in touch',
              style: TextStyle(
                color: _ink,
                fontSize: 20,
                letterSpacing: -0.4,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'The best way to reach me is by email or phone.',
            style: _supporting,
          ),
          const SizedBox(height: 21),
          const _ContactRow(
            label: 'Email',
            value: _email,
            icon: Icons.mail_outline_rounded,
          ),
          const SizedBox(height: 10),
          const _ContactRow(
            label: 'Phone',
            value: _phone,
            icon: Icons.phone_outlined,
          ),
          const SizedBox(height: 26),
          const Divider(height: 1, color: Color(0xFFE5EDE8)),
          const SizedBox(height: 17),
          const Text('AI DEVELOPER', style: _eyebrow),
          const SizedBox(height: 5),
          const Text(
            'Turning ideas into useful, intelligent experiences.',
            style: _supporting,
          ),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  Future<void> _copy(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    String message;
    try {
      await Clipboard.setData(ClipboardData(text: value));
      message = '$label copied';
    } on PlatformException {
      message = 'Could not copy ${label.toLowerCase()}';
    }
    if (!context.mounted) return;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFF0F6F3),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xFFE6EFEB)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 3, bottom: 3),
        child: Row(
          children: [
            Icon(icon, color: _teal, size: 16),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label.toUpperCase(), style: _eyebrow),
                  const SizedBox(height: 2),
                  SelectableText(
                    value,
                    style: const TextStyle(
                      color: _ink,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Copy ${label.toLowerCase()}',
              onPressed: () => _copy(context),
              color: _teal,
              icon: const Icon(Icons.content_copy_rounded, size: 15),
            ),
          ],
        ),
      ),
    );
  }
}
