import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/views/user_main_views/coustom_wedgets/user_wedgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PayWaysScreen extends StatelessWidget {
  const PayWaysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          mainScreenAppbar(
            title: "طرق الدفع",
          ),
          SizedBox(
            height: 100,
          ),
          HomeScreenBotton(
            text: "إضافه بطاقة جديده",
            color: Color(0xff2C5602),
            textcolor: Colors.white,
          )
        ],
      ),
    );
  }
}
