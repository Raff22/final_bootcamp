import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:flutter/material.dart';

class LoginOrSignupWidget extends StatelessWidget {
  const LoginOrSignupWidget(
      {super.key,
      required this.askText,
      required this.textButtom,
      required this.navigatorTo});

  final String askText;
  final String textButtom;
  final Function() navigatorTo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // -------------------------------------------------

        InkWell(
          onTap: navigatorTo,
          child: TextWidget(
            text: textButtom,
            textDecoration: TextDecoration.underline,
          ),
        ),
        width2,

        // -------------------------------------------------

        TextWidget(text: askText),
      ],
    );
  }
}
