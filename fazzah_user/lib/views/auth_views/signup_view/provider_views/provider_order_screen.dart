import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/views/auth_views/signup_view/provider_views/provider_chat.dart';
import 'package:fazzah_user/views/user_main_views/coustom_wedgets/user_wedgets.dart';
import 'package:flutter/material.dart';

class ProviderOrderScreen extends StatelessWidget {
  const ProviderOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const mainScreenAppbar(title: "الطلبات"),
          ElevatedButton(
              onPressed: () {
                context.pushScreen(screen: const ProviderChat());
              },
              child: const Text("orders"))
        ],
      ),
    );
  }
}
