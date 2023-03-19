import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:omgnp/App.dart';
import 'package:omgnp/Patti/NewPattiForm.dart';
import 'package:omgnp/Patti/NewPatti.dart';
import 'package:omgnp/firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const App();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      routes: {
        NewPattiForm.pageRoute : (context) => const NewPattiForm(),
        NewPatti.pageRoute : (context) => const NewPatti()
      },
    );
  }
}