import 'package:flutter/material.dart';

class XylophoneButton extends StatelessWidget {
  const XylophoneButton({
    super.key,
    required this.note,
    required this.color,
    required this.onPressed,
  });

  final String note;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(13),
    );

    return Material(
      color: color,
      elevation: 2,
      shadowColor: Colors.black54,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.lerp(color, Colors.white, 0.22)!,
              color,
              Color.lerp(color, const Color(0xFF362739), 0.10)!,
            ],
          ),
        ),
        child: Semantics(
          button: true,
          child: InkWell(
            onTap: onPressed,
            customBorder: shape,
            hoverColor: const Color(0x23FFFFFF),
            focusColor: const Color(0x40000000),
            highlightColor: const Color(0x33000000),
            splashColor: const Color(0x66FFFFFF),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  const _Pin(),
                  Expanded(
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          note,
                          style: const TextStyle(
                            color: Color(0xFF292330),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const _Pin(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Pin extends StatelessWidget {
  const _Pin();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0x39362A39),
        shape: BoxShape.circle,
      ),
      child: SizedBox.square(dimension: 6),
    );
  }
}
