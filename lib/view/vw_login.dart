import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  'home',
                  (Route<dynamic> route) => false,
                );
              },
              icon: const Icon(Icons.cancel, size: 30.0),
              color: Colors.red,
            ),
            Text('Login'),
          ],
        ),
      ),
    );
  }
}
