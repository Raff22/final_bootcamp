// ignore_for_file: must_be_immutable

import 'package:fazzah_user/bloc/order_bloc/order_bloc.dart';
import 'package:fazzah_user/bloc/order_bloc/order_event.dart';
import 'package:fazzah_user/bloc/order_bloc/order_state.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/container_widget.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/rating_model.dart';
import 'package:fazzah_user/models/user_model.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/loading_func.dart';
import 'package:fazzah_user/utils/helpers/show_message_green.dart';
import 'package:fazzah_user/views/user_main_views/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBottomSheet extends StatelessWidget {
  RatingBottomSheet({
    super.key,
    required this.provider,
    required this.user,
  });
  ProviderModel provider;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    TextEditingController commentController = TextEditingController();
    double rate = 0;

    return BottomSheet(
      backgroundColor: white,
      enableDrag: false,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: white),
          width: context.getWidth(),
          height: 478,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                height38,
                const TextWidget(
                  text: "كيف كانت خدمة الفني؟",
                  textSize: 22,
                ),
                height20,
                RatingBar.builder(
                  initialRating: 1,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star_rate_rounded,
                    color: coldGreen,
                  ),
                  onRatingUpdate: (rating) {
                    rate = rating;
                  },
                ),
                height20,
                TextField(
                  controller: commentController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(16)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(16)),
                    hintText: "شاركنا تجربتك",
                    hintStyle: const TextStyle(color: grey, fontSize: 22),
                    filled: true, //<-- SEE HERE
                    fillColor: lightGrey, //<-- SEE HERE
                  ),
                ),
                height20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocListener<OrderBloc, OrderState>(
                      listener: (context, state) {
                        if (state is OrderLoadingState) {
                          showLoadingDialog(context: context);
                        }
                        Navigator.of(context, rootNavigator: true).pop();
                        if (state is RatingAddedSuccessfully) {
                          context.removeUnitl(screen: NavBar(user: user));
                          showMessageDialog(
                              context: context, message: "تم تسجيل تقييمك");
                        }
                      },
                      child: ContainerWidget(
                          contanierBorderRadius: 10,
                          containerWidth: 225,
                          containerHeight: 45,
                          containerColor: green,
                          onPressed: () {
                            context.read<OrderBloc>().add(RatingAddingEvent(
                                provider: provider,
                                rating: Rating(
                                    createdAt: DateTime.now().toIso8601String(),
                                    rate: rate.round(),
                                    comment: commentController.text.trim(),
                                    user: user.id!,
                                    provider: provider.id!,
                                    userName: user.name!)));
                          },
                          child: const Center(
                              child: TextWidget(
                            text: "إرسال",
                            textSize: 20,
                            textColor: lightGrey,
                          ))),
                    ),
                    TextButton(
                        onPressed: () {
                          context.removeUnitl(screen: NavBar(user: user));
                        },
                        child: const TextWidget(
                          text: "تخطي",
                          textColor: grey,
                          textSize: 20,
                        )),
                  ],
                )
              ],
            ),
          ),
        );
      },
      onClosing: () {},
    );
  }
}
