import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/container_widget.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/views/auth_views/login_view/login_view.dart';
import 'package:flutter/material.dart';

class RowBelowOnboardingWidget extends StatelessWidget {
  const RowBelowOnboardingWidget({super.key, required this.nextPage});

  final Function() nextPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // --------------  Green Container (التالي)  ---------------
        ContainerWidget(
          onPressed: nextPage,
          containerHeight: 48,
          containerWidth: 100,
          contanierBorderRadius: 10,
          containerColor: green,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back_ios_new,
                color: lightGrey,
              ),
              width6,
              TextWidget(
                text: 'التالي',
                textSize: 20,
                textColor: lightGrey,
              ),
            ],
          ),
        ),

        // --------------  Container (تخطي)  ---------------
        ContainerWidget(
          onPressed: () {
            context.pushScreen(screen:  LoginView());
          },
          containerHeight: 48,
          containerWidth: 100,
          contanierBorderRadius: 0,
          containerColor: noColor,
          child: const Center(
            child: TextWidget(
              text: 'تخطي',
              textSize: 20,
              textColor: dark1Green,
            ),
          ),
        ),
      ],
    );
  }
}
