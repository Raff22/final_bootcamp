import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/views/user_main_views/coustom_wedgets/user_wedgets.dart';
import 'package:flutter/material.dart';

class PayWaysScreen extends StatelessWidget {
  const PayWaysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(
          context: context,
          title: 'طرق الدفع',
          centerTitle: true,
          
          leading: IconButton(
              onPressed: () {
                context.popScreen();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded))),
      body: SizedBox(
        width: context.getWidth(),
        child: const Column(
          children: [
            HomeScreenBotton(
              text: "إضافه بطاقة جديده",
              color: Color(0xff2C5602),
              textcolor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
