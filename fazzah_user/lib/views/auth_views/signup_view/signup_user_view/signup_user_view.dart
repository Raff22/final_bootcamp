import 'package:flutter/material.dart';

class SignupUserView extends StatelessWidget {
  const SignupUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Text('User Sign UP'),
      )),
    );
  }
}
