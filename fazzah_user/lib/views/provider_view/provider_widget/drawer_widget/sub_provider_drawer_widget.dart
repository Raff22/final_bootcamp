import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:flutter/material.dart';

class SubProviderDrawerWidget extends StatelessWidget {
  const SubProviderDrawerWidget(
      {super.key,
      required this.iconString,
      required this.subTextView,
      required this.onPressed});
  final String iconString;
  final String subTextView;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    iconString,
                    color: green,
                  ),
                  width10,
                  TextWidget(
                    text: subTextView,
                    textColor: green,
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: green,
              )
            ],
          ),
          height10,
          const Divider(
            color: green,
            height: 2,
          )
        ],
      ),
    );
  }
}
