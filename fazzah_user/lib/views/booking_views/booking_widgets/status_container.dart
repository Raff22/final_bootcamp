import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:flutter/material.dart';

class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({
    super.key,
    required this.status,
    this.textColor = green,
  });

  final String status;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 25,
        width: 65,
        decoration: BoxDecoration(
          color: lightGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: TextWidget(text: status, textColor: textColor, textSize: 16),
        ));
  }
}
