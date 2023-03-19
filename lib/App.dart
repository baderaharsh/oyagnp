import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:omgnp/Screens/Auth.dart';
import 'package:omgnp/Screens/Home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: Text("Fetching user data...."),
        );
      }

      if(snapshot.hasData) {
        return const Home();
      }

      return const Auth();
    },);
  }
}