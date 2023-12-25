import 'package:fazzah_user/models/user_model.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/views/auth_views/login_view/login_view.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key, required this.userModel});

  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: const Icon(Icons.login),
        onPressed: () {
          context.pushScreen(screen: LoginView());
        },
      )),
      body: Center(
          child: Column(
        children: [
          Text(userModel!.email!),
          Text(userModel!.id!),
          Text(userModel!.name!),
          Text(userModel!.phoneNumber!)
        ],
      )),
    );
  }
}
