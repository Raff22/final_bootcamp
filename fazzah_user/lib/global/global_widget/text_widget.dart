import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {super.key,
      required this.text,
      this.textColor,
      this.textSize,
      this.textFontFamily,
      this.textFontWeight,
      this.textAlign,
      this.textDecoration});

  final String text;
  final Color? textColor;
  final double? textSize;
  final String? textFontFamily;
  final FontWeight? textFontWeight;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        decoration: textDecoration,
        fontFamily: textFontFamily,
        fontSize: textSize,
        fontWeight: textFontWeight,
        color: textColor,
      ),
      textAlign: textAlign,
    );
  }
}
