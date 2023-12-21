import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/views/auth_views/onboarding_view/first_onboarding_view.dart';
import 'package:flutter/material.dart';

class LogoView extends StatefulWidget {
  const LogoView({super.key});

  @override
  State<LogoView> createState() => _LogoViewState();
}

class _LogoViewState extends State<LogoView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      context.pushScreen(screen: const FirstOnboardingView());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(child: Image.asset('assets/images/logo_user.gif'))),
    );
  }
}




// import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
// import 'package:fazzah_user/utils/extentions/size_extentions.dart';
// import 'package:fazzah_user/views/auth_views/onboarding_view/first_onboarding_view.dart';
// import 'package:flutter/material.dart';

// class LogoView extends StatefulWidget {
//   const LogoView({
//     super.key,
//   });

//   @override
//   State<LogoView> createState() => _LogoViewState();
// }

// class _LogoViewState extends State<LogoView> {
//   double top = 300;
//   bool text = false;

//   @override
//   void initState() {
//     topPosition();
//     super.initState();
//   }

//   topPosition() {
//     Future.delayed(const Duration(milliseconds: 100), () {
//       setState(() {
//         top = 100;
//       });
//     });
//     Future.delayed(const Duration(seconds: 2), () {
//       setState(() {
//         text = true;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(children: [
//           Container(
//             height: context.getHeight(),
//             width: context.getWidth(),
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               AnimatedPositioned(
//                 top: top,
//                 // left: MediaQuery.of(context).size.width * 0.25,
//                 curve: Curves.elasticOut,
//                 duration: const Duration(seconds: 2),
//                 child: Image.asset(
//                   "assets/images/Logo.png",
//                 ),
//               ),
//               text
//                   ? AnimatedPositioned(
//                       top: top,
//                       // left: MediaQuery.of(context).size.width * 0.25,
//                       curve: Curves.easeIn,
//                       duration: const Duration(seconds: 2),
//                       child: Image.asset(
//                         "assets/images/Text.png",
//                       ),
//                     )
//                   : Container()
//             ],
//           )
//         ]),
//       ),
//     );
//   }
// }
