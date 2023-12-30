import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/rating_model.dart';
import 'package:flutter/material.dart';

class RatingAverageWidget extends StatelessWidget {
  const RatingAverageWidget({
    super.key,
    required this.providerModel,
    required this.ratings,
  });

  final ProviderModel providerModel;
  final List<Rating> ratings;

  @override
  Widget build(BuildContext context) {
    num stars = providerModel.rateAverage!;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(5, (i) {
            return Row(
              children: [
                Row(
                    children: List.generate(
                        i + 1,
                        (index) => const Icon(Icons.star_purple500_outlined,
                            color: coldGreen))),
                width10,
                Text("${getCount(i + 1) ?? ""}"),
              ],
            );
          })),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextWidget(text: "${providerModel.rateAverage!}", textSize: 68),
        Row(
          children: List.generate(5, (index) {
            if (stars > 0) {
              stars--;
              return const Icon(Icons.star_purple500_outlined,
                  color: coldGreen);
            }
            return const Icon(Icons.star_purple500_outlined, color: lightGrey);
          }),
        ),
      ]),
    ]);
  }

  int? getCount(int x) {
    int z = 0;
    for (var element in ratings) {
      if (element.rate == x) {
        z++;
      }
    }
    if (z > 0) {
      return z;
    }
    return null;
  }
}
