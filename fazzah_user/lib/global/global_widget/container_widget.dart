import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget(
      {super.key,
      this.onPressed,
      this.containerHeight,
      this.containerWidth,
      required this.contanierBorderRadius,
      this.containerColor,
      this.child});

  final Function()? onPressed;
  final double? containerHeight;
  final double? containerWidth;
  final double contanierBorderRadius;
  final Color? containerColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          height: containerHeight,
          width: containerWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(contanierBorderRadius),
              color: containerColor),
          child: child),
    );
  }
}
