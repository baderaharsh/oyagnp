import 'package:flutter/material.dart';

class TableText extends StatelessWidget {
  final String text;
  const TableText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(4), child: Text(text, textAlign: TextAlign.right),);
  }
}