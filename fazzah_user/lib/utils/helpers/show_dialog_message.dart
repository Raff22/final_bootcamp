import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:flutter/material.dart';

Future<dynamic> showDialogAlertMessage(
    {required BuildContext context,
    required String contentText,
    required String titleText,
    required Function() onPressed}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: TextWidget(
        text: titleText,
        textColor: dark1Green,
        textAlign: TextAlign.center,
      ),
      content: TextWidget(
        text: contentText,
        textColor: green,
        textSize: 18,
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
            onPressed: onPressed,
            child: const TextWidget(
              text: 'حسناََ',
              textSize: 18,
              textColor: green,
            )),
      ],
    ),
  );
}
