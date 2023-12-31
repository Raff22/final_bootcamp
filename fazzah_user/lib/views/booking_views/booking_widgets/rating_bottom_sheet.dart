import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/show_message_green.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

extension RatingBottomSheet on BuildContext {
  showRating(ProviderModel provider) {
    showBottomSheet(
        context: this,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            width: context.getWidth(),
            height: 478,
            child: Column(
              children: [
                const TextWidget(
                  text: "كيف كانت خدمة الفني؟",
                  textSize: 22,
                ),
                RatingBar(
                  initialRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                    full: const Icon(Icons.star_border),
                    half: const Icon(Icons.star_border),
                    empty: const Icon(Icons.star_border),
                  ),
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                const TextField(),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          // context.removeUnitl(screen: NavBar(user: user));
                          showMessageDialog(
                              context: context, message: "تم تسجيل تقييمك");
                        },
                        child: const Text("ارسال")),
                    TextButton(
                        onPressed: () {
                          context.popScreen();
                        },
                        child: const Text("تخطي"))
                  ],
                )
              ],
            ),
          );
        });
  }
}
