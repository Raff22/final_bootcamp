import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      {super.key,
      this.validator,
      required this.keyboardType,
      required this.controller,
      required this.labelText,
      required this.labelTextColor,
      required this.cursorColor,
      required this.controllerTextColor,
      this.suffixIcon,
      required this.obscureText,
      this.hintText});

  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String labelText;
  final Color labelTextColor;
  final Color cursorColor;
  final Color controllerTextColor;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      style: TextStyle(color: controllerTextColor),
      cursorColor: cursorColor,
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: lightGrey),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          contentPadding: const EdgeInsets.all(10),
          label: TextWidget(
            text: labelText,
            textColor: labelTextColor,
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: grey),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: grey),
              borderRadius: BorderRadius.circular(10)),
          suffixIcon: suffixIcon),
    );
  }
}
