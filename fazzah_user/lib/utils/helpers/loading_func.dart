import 'package:fazzah_user/constant/color.dart';
import 'package:flutter/material.dart';

showLoadingDialog({required BuildContext context}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(child: CircularProgressIndicator(color: green));
      });
}
