import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/views/auth_views/onboarding_view/onbording_widgets/onboarding_widget.dart';
import 'package:fazzah_user/views/auth_views/onboarding_view/onbording_widgets/row_below_onboarding.dart';
import 'package:fazzah_user/views/auth_views/onboarding_view/second_onboarding_view.dart';
import 'package:flutter/material.dart';

class FirstOnboardingView extends StatelessWidget {
  const FirstOnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingWidget(
        imagePath: 'assets/images/Electrician-pana 1.png',
        onboardingText: 'اطلب صيانتك في اقل من دقيقة',
        firstHeightDot: 7,
        firstWidthDot: 30,
        firstRadiusDot: 7,
        secondHeightDot: 7,
        secondWidthDot: 7,
        secondRadiusDot: 7,
        thirdHeightDot: 7,
        thirdWidthDot: 7,
        thirdRadiusDot: 7,
        belowOnboardingWidget: RowBelowOnboardingWidget(nextPage: () {
          context.pushScreen(screen: const SecondOnboardingView());
        }),
      ),
    );
  }
}
