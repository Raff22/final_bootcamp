import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/views/auth_views/onboarding_view/onbording_widgets/dot_onboarding_widget.dart';
import 'package:flutter/material.dart';

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget(
      {super.key,
      required this.imagePath,
      required this.onboardingText,
      required this.belowOnboardingWidget,
      required this.firstHeightDot,
      required this.firstWidthDot,
      required this.firstRadiusDot,
      required this.secondHeightDot,
      required this.secondWidthDot,
      required this.secondRadiusDot,
      required this.thirdHeightDot,
      required this.thirdWidthDot,
      required this.thirdRadiusDot});

  final String imagePath;
  final String onboardingText;
  final Widget belowOnboardingWidget;
  final double firstHeightDot;
  final double firstWidthDot;
  final double firstRadiusDot;
  final double secondHeightDot;
  final double secondWidthDot;
  final double secondRadiusDot;
  final double thirdHeightDot;
  final double thirdWidthDot;
  final double thirdRadiusDot;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.getHeight(),
      width: context.getWidth(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ----------------- main content Screen ----------------
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      height50,
                      height50,
                      // ----------  image  --------
                      Image.asset(
                        imagePath,
                        width: 377.5,
                        height: 251.67,
                      ),
                      height40,

                      // ----------  text  --------
                      TextWidget(
                        textAlign: TextAlign.center,
                        text: onboardingText,
                        textSize: 28,
                        textColor: dark1Green,
                      ),
                    ],
                  ),

                  height30,
                  height30,
                  // ----------  dot Screen  --------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DotOnboardingWidget(
                        heightDot: thirdHeightDot,
                        widthDot: thirdWidthDot,
                        borderRadiusDot: thirdRadiusDot,
                        colorDot: green,
                      ),
                      width4,
                      DotOnboardingWidget(
                        heightDot: secondHeightDot,
                        widthDot: secondWidthDot,
                        borderRadiusDot: secondRadiusDot,
                        colorDot: green,
                      ),
                      width4,
                      DotOnboardingWidget(
                        heightDot: firstHeightDot,
                        widthDot: firstWidthDot,
                        borderRadiusDot: firstRadiusDot,
                        colorDot: green,
                      )
                    ],
                  ),
                ],
              ),

              // ------------------ Below the Screen ----------------------
              belowOnboardingWidget
            ],
          ),
        ),
      ),
    );
  }
}
