import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:flutter/material.dart';

class TitleView extends StatelessWidget {
  const TitleView({super.key, required this.title, required this.supTitle});
  final String title;
  final String supTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.getWidth(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextWidget(
            text: title,
            textSize: 34,
          ),
          height12,
          TextWidget(
            text: supTitle,
            textSize: 18,
          )
        ],
      ),
    );
  }
}
