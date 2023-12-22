import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:flutter/material.dart';

class ProviderScreen extends StatelessWidget {
  const ProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.getHeight(divide: 9),
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios, size: 20, color: black)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        )),
        foregroundColor: black,
        backgroundColor: lightGreen,
        title: const TextWidget(
          text: "تفاصيل الحجز",
          textSize: 28,
        ),
      ),
      // body: Column(
      //   children: [
      //     Container(
      //       width: context.getWidth(),
      //       height: context.getHeight(divide: 7),
      //       decoration: const BoxDecoration(
      //           color: lightGreen,
      //           borderRadius: BorderRadius.only(
      //               bottomLeft: Radius.circular(16),
      //               bottomRight: Radius.circular(16))),
      //       child: Padding(
      //         padding: const EdgeInsets.only(top: 50.0),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             const TextWidget(
      //               text: "تفاصيل الحجز",
      //               textSize: 28,
      //             ),
      //             IconButton(
      //                 onPressed: () {},
      //                 icon: const Icon(Icons.arrow_forward_ios_outlined,
      //                     size: 20, color: black))
      //           ],
      //         ),
      //       ),
      //     )
    );
  }
}
