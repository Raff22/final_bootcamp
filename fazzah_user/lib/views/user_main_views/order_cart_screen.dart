import 'package:fazzah_user/views/booking_views/tracking_view.dart';
import 'package:fazzah_user/views/chat_views/chat_widgets/chating_screen.dart';
import 'package:fazzah_user/views/chat_views/chat_widgets/test_page.dart';
import 'package:fazzah_user/views/user_main_views/coustom_wedgets/user_wedgets.dart';
import 'package:fazzah_user/views/user_main_views/nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderCartScreen extends StatelessWidget {
  const OrderCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          mainScreenAppbar(title: "طلباتي"),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Text("chating"))
        ],
      ),
    );
  }
}
