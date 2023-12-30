// ignore_for_file: must_be_immutable

import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:flutter/material.dart';

class TextFieldProviderInfoWidget extends StatelessWidget {
   TextFieldProviderInfoWidget(
      {super.key,
      required this.labelText,
      required this.controllerText,
      this.onChanged,
      this.validator,
      required this.keyboardType});
  final String labelText;
  TextEditingController controllerText;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: context.getWidth(),
          child: TextWidget(
            text: labelText,
            textColor: dark1Green,
            textSize: 20,
          ),
        ),
        TextFormField(
          validator: validator,
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: const TextStyle(color: grey),
          cursorColor: grey,
          controller: controllerText,
          decoration: const InputDecoration(
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: grey)),
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: grey)),
          ),
        )
      ],
    );
  }
}
