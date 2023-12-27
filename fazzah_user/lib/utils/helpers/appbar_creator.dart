import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:flutter/material.dart';

AppBar createAppBar(
    {required BuildContext context,
    Widget? leading,
    String? title,
    bool? centerTitle}) {
  return AppBar(
    toolbarHeight: context.getHeight(divide: 13),
    leading: leading,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(15),
    )),
    foregroundColor: black,
    backgroundColor: lightGreen,
    centerTitle: centerTitle,
    title: TextWidget(
      text: title ?? "",
      textSize: 28,
    ),
  );
}
