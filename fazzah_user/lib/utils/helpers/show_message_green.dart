import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:flutter/material.dart';

showMessageDialog({required BuildContext context, required String message}) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Center(
            child: Container(
                width: 364,
                height: 58,
                color: coldGreen,
                child: Center(
                    child: TextWidget(
                        text: message, textColor: green, textSize: 20))));
      });
}
