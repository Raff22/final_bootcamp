import 'package:flutter/material.dart';

class DotOnboardingWidget extends StatelessWidget {
  const DotOnboardingWidget(
      {super.key,
      required this.heightDot,
      required this.widthDot,
      required this.borderRadiusDot,
      required this.colorDot});

  final double heightDot;
  final double widthDot;
  final double borderRadiusDot;
  final Color colorDot;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightDot,
      width: widthDot,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadiusDot),
        color: colorDot,
      ),
    );
  }
}
