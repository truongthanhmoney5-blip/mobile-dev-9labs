import 'dart:math';

import 'package:flutter/material.dart';

class Rolldice extends StatefulWidget {
  const Rolldice({super.key});

  @override
  State<Rolldice> createState() => _RolldiceState();
}

class _RolldiceState extends State<Rolldice> {
  var activeDice = 'assets/images/1.png';
  void rolling() {
    var random = Random().nextInt(6) + 1;
    setState(() {
      activeDice = 'assets/images/$random.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(children: [
        Image.asset(
          activeDice,
          width: 150,
          height: 150,
        ),
        const SizedBox(height: 70),
        ElevatedButton(onPressed: rolling, child: const Text('Roll Dice!'))
      ]),
    );
  }
}
