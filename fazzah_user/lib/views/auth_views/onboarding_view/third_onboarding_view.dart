import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/global/global_widget/container_widget.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/views/auth_views/login_view/login_view.dart';
import 'package:fazzah_user/views/auth_views/onboarding_view/onbording_widgets/onboarding_widget.dart';
import 'package:flutter/material.dart';

class ThirdOnboardingView extends StatelessWidget {
  const ThirdOnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingWidget(
        imagePath: 'assets/images/Electrician-amico 1.png',
        onboardingText: '٣ خطوات بسيطة ويوصلك من يحل مشكلتك',
              firstHeightDot: 7,
        firstWidthDot: 7,
        firstRadiusDot: 7,
        secondHeightDot: 7,
        secondWidthDot: 7,
        secondRadiusDot: 7,
        thirdHeightDot: 7,
        thirdWidthDot: 30,
        thirdRadiusDot: 7,
        belowOnboardingWidget: ContainerWidget(
          contanierBorderRadius: 10,
          containerWidth: context.getWidth(),
          containerHeight: 48,
          containerColor: green,
          onPressed: () {
            context.pushScreen(screen:  LoginView());
          },
          child: const Center(
              child: TextWidget(
            text: 'ابدأ',
            textSize: 25,
            textColor: lightGrey,
          )),
        ),
      ),
    );
  }
}
