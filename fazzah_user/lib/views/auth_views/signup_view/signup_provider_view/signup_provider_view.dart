import 'package:flutter/material.dart';

class SignupProviderView extends StatelessWidget {
  const SignupProviderView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Text('Provider Sign UP'),
      )),
    );
  }
}
