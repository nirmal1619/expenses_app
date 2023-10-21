import 'package:flutter/material.dart';

class TStructure extends StatelessWidget {

  final String text;
  final Color tColor;
  final double tSize;

  const TStructure({super.key, required this.text, required this.tColor, required this.tSize});



  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: tColor,
        fontSize: tSize,
      ),
    );
  }
}