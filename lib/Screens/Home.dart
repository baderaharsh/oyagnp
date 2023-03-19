import 'package:flutter/material.dart';
import 'package:omgnp/Patti/NewPattiForm.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: const Center(
        child: Text("You're in"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(NewPattiForm.pageRoute);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
