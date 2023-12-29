import 'package:fazzah_user/views/user_main_views/coustom_wedgets/user_wedgets.dart';
import 'package:flutter/material.dart';

class OrderCartScreen extends StatelessWidget {
  const OrderCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          mainScreenAppbar(title: "طلباتي"),
        ],
      ),
    );
  }
}
