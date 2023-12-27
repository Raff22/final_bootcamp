import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:flutter/material.dart';

Future<dynamic> showDialogAlerttt(
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
                    text: 'نعم',
                    textSize: 18,
                    textColor: green,
                  )),
              TextButton(
                onPressed: () => context.popScreen(),
                child: const TextWidget(
                  text: 'إلغاء',
                  textSize: 18,
                  textColor: green,
                ),
              )
            ],
          ));
}
