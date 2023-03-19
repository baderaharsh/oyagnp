import 'package:flutter/material.dart';

class TableText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double size;
  const TableText(this.text, {this.textAlign = TextAlign.right, super.key, this.size = 14});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(4), child: Text(text, textAlign: textAlign, style: TextStyle(fontSize: size,)),);
  }
}