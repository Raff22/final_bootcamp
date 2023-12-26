import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
    required this.priceRange,
  });
  final String priceRange;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const TextWidget(
          text: "قيمة اليد العاملة",
          textSize: 22,
          textFontWeight: FontWeight.w500,
        ),
        TextWidget(
          text:
              "${(int.parse(priceRange.split('-')[0]) + int.parse(priceRange.split('-')[1]) / 2)} SAR",
          textSize: 22,
          textFontWeight: FontWeight.bold,
          textColor: green,
        ),
      ],
    );
  }
}
