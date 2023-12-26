import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/views/auth_views/login_view/login_view.dart';
import 'package:flutter/material.dart';

class ProviderHomePage extends StatelessWidget {
  const ProviderHomePage({super.key, required this.providerModel});

  final ProviderModel? providerModel;

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
          Text(providerModel!.email!),
          Text(providerModel!.id!),
          Text(providerModel!.name!),
          Text(providerModel!.phoneNumber!)
        ],
      )),
    );
  }
}
