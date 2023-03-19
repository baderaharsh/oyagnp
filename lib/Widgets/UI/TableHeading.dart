import 'package:flutter/material.dart';

class TableHeading extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double size;
  const TableHeading(this.text, {this.textAlign = TextAlign.center, super.key, this.size = 14});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: size,
        ),
      ),
    );
  }
}
