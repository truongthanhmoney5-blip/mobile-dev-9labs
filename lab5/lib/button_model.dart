import 'package:flutter/material.dart';

class ButtonModel {
  const ButtonModel(this.audioName, this.note, this.color);

  final String audioName;
  final String note;
  final Color color;
}

const allButtons = [
  ButtonModel('note1', 'Đô', Color(0xFFF2A594)),
  ButtonModel('note2', 'Rê', Color(0xFFF1BD87)),
  ButtonModel('note3', 'Mi', Color(0xFFEED492)),
  ButtonModel('note4', 'Fa', Color(0xFFC8D5A2)),
  ButtonModel('note5', 'Sol', Color(0xFFA5D3B7)),
  ButtonModel('note6', 'La', Color(0xFFA5C9E1)),
  ButtonModel('note7', 'Si', Color(0xFFC5BAE8)),
];
