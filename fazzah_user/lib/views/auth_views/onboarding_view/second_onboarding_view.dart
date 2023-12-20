import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/views/auth_views/onboarding_view/onbording_widgets/onboarding_widget.dart';
import 'package:fazzah_user/views/auth_views/onboarding_view/onbording_widgets/row_below_onboarding.dart';
import 'package:fazzah_user/views/auth_views/onboarding_view/third_onboarding_view.dart';
import 'package:flutter/material.dart';

class SecondOnboardingView extends StatelessWidget {
  const SecondOnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingWidget(
        imagePath: 'assets/images/Electrician-cuate 1.png',
        onboardingText: 'اكثر من ٢٠ خدمة صيانة لمنزلك بأسعار موحدة',
        firstHeightDot: 7,
        firstWidthDot: 7,
        firstRadiusDot: 7,
        secondHeightDot: 7,
        secondWidthDot: 30,
        secondRadiusDot: 7,
        thirdHeightDot: 7,
        thirdWidthDot: 7,
        thirdRadiusDot: 7,
        belowOnboardingWidget: RowBelowOnboardingWidget(
          nextPage: () {
            context.pushScreen(screen: const ThirdOnboardingView());
          },
        ),
      ),
    );
  }
}
