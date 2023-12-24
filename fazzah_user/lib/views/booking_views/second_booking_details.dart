import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:flutter/material.dart';

class SecondBookingDetails extends StatelessWidget {
  const SecondBookingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: createAppBar(
            title: "تفاصيل الحجز",
            context: context,
            leading: IconButton(
                onPressed: () {
                  context.popScreen();
                },
                icon:
                    const Icon(Icons.arrow_back_ios, size: 20, color: black))),
        body: const Text("data"));
  }
}
