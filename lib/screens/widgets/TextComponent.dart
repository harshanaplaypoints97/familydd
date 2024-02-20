import 'dart:ui';

import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  String text;
  final Color color;

  FontWeight fontWeight;
  double fontsize;

  TextComponent(
      {super.key,
      required this.color,
      required this.fontWeight,
      required this.fontsize,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(fontWeight: fontWeight, color: color, fontSize: fontsize),
    );
  }
}
