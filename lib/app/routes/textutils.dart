import 'package:flutter/material.dart';

class TextUtils extends StatelessWidget {
  const TextUtils(
      {Key? key,
      required this.text,
      required this.textalign,
      required this.color,
      required this.fontWeight})
      : super(key: key);
  final String text;
  final TextAlign textalign;
  final Color color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textalign,
      style: TextStyle(color: color, fontWeight: FontWeight.bold),
    );
  }
}
