import 'package:fazzah_user/utils/imports.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
    required this.priceRange,
  });
  final String priceRange;

  @override
  Widget build(BuildContext context) {
    int num1 = int.parse(priceRange.split('-')[0]);
    int num2 = int.parse(priceRange.split('-')[1]);
    num avg = num1 + num2;
    avg = avg * 0.5;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const TextWidget(
          text: "قيمة اليد العاملة",
          textSize: 22,
          textFontWeight: FontWeight.w500,
        ),
        TextWidget(
          text: "$avg SAR",
          textSize: 22,
          textFontWeight: FontWeight.bold,
          textColor: green,
        ),
      ],
    );
  }
}
