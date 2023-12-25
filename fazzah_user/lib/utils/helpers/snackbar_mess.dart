import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:flutter/material.dart';

snackBarMassage({required BuildContext context, required String snackBarText}) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: TextWidget(text: snackBarText)));
}
