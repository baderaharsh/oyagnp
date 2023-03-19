import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  String _username = '';
  String _password = '';

  var isError = false;
  var isLoading = false;

  final errorMessage = 'Something went wrong! Please try again later.';

  void authenticateUser(String username, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: password);
    } catch (error) {
      // ignore: avoid_print
      print(error.toString());
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(
            top: size.height * 0.07,
          ),
          width: size.width * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  _username = value;
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                ),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  _password = value;
                },
                obscureText: true,
              ),
              if (isError) Text(errorMessage),
              const SizedBox(
                height: 10,
              ),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                          authenticateUser(_username, _password);
                        });
                      },
                      child: const Text('Login'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
