import 'package:fazzah_user/utils/imports.dart';

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
