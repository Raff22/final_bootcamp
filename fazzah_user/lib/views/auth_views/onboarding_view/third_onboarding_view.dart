import 'package:fazzah_user/utils/imports.dart';

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
            context.removeUnitl(screen: LoginView());
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
