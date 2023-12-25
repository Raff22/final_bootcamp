import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/views/auth_views/login_view/login_view.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: Icon(Icons.login),
        onPressed: () {
          context.pushScreen(screen: LoginView());
        },
      )),
      body: Center(child: Text("User Home page")),
    );
  }
}
