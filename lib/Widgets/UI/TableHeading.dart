import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TableHeading extends StatelessWidget {
  final String text;
  const TableHeading(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(4), child: Text(text, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),);
  }
}