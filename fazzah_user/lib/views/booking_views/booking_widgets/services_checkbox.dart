import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:flutter/material.dart';

class ServiceCheckBox extends StatelessWidget {
  const ServiceCheckBox(
      {super.key, required this.serviceName, required this.state});
  final String serviceName;
  final bool state;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: state,
            onChanged: (value) {},
            fillColor: null,
            activeColor: black),
        TextWidget(
          text: serviceName,
          textSize: 22,
        ),
      ],
    );
  }
}