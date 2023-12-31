// ignore_for_file: unnecessary_const

import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/models/user_model.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/views/user_main_views/blocks/user_bloc.dart';
import 'package:fazzah_user/views/user_main_views/blocks/user_event.dart';
import 'package:fazzah_user/views/user_main_views/coustom_wedgets/user_wedgets.dart';
import 'package:fazzah_user/views/user_main_views/more_screens/about_Fazaah.dart';
import 'package:fazzah_user/views/user_main_views/more_screens/my_account.dart';
import 'package:fazzah_user/views/user_main_views/more_screens/my_places.dart';
import 'package:fazzah_user/views/user_main_views/more_screens/pay_ways.dart';
import 'package:fazzah_user/views/user_main_views/more_screens/polcies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ------------- appbar ------------------
          const mainScreenAppbar(title: "المزيد"),
          const SizedBox(
            height: 30,
          ),

          // ----------------------------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MoreSelectWidget(
                  iconeImage: 'assets/images/1.png',
                  textScreenName: 'حسابي',
                  onPressd: () {
                    context.pushScreen(
                        screen: MyAccountScreen(
                      user: user,
                    ));
                  },
                  iconWidget: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                height20,
                // ----------------------------------------
                MoreSelectWidget(
                  iconeImage: 'assets/images/2.png',
                  textScreenName: 'عناويني المحفوظه',
                  onPressd: () {
                    context.read<UserBloc>().add(GetAllUserAddressEvent());
                    context.pushScreen(
                        screen: MyPlacesScreen(
                      user: user,
                    ));
                  },
                  iconWidget: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                height20,
                // ----------------------------------------
                MoreSelectWidget(
                  iconeImage: 'assets/images/3.png',
                  textScreenName: 'طرق الدفع',
                  onPressd: () {
                    context.pushScreen(screen: const PayWaysScreen());
                  },
                  iconWidget: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                height20,
                // ----------------------------------------
                MoreSelectWidget(
                  iconeImage: 'assets/images/4.png',
                  textScreenName: 'عن فزعة',
                  onPressd: () {
                    context.pushScreen(screen: const AboutFazzahScreen());
                  },
                  iconWidget: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                height20,
                // ----------------------------------------
                MoreSelectWidget(
                  iconeImage: 'assets/images/5.png',
                  textScreenName: 'سياسة الخصوصية',
                  onPressd: () {
                    context.pushScreen(screen: const PoliciesScreen());
                  },
                  iconWidget: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                height20,
                // ----------------------------------------
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextWidget(
                            text: 'الوضع الليلي',
                            textColor: green,
                            textSize: 20),
                        Image.asset('assets/images/light_dark_mood.png'),
                      ],
                    ),

                    //---------- divider -------------
                    const Divider(
                      color: green,
                    )
                  ],
                ),
                height20,
                // ----------------------------------------
                MoreSelectWidget(
                  iconeImage: 'assets/images/7.png',
                  textScreenName: 'تسجيل خروج',
                  onPressd: () {
                    // sign out
                  },
                  iconWidget: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                height20,
                InkWell(
                  onTap: () {
                    // delete account
                  },
                  child: const TextWidget(
                    text: 'حذف الحساب',
                    textColor: red,
                    textSize: 18,
                  ),
                )
              ],
            ),
          )
          // moreSelector(
          //   fun: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (context) {
          //       return MyAccountScreen();
          //     }));
          //   },
          //   icon: Icons.person,
          //   text: ,
          //   icon2: Icons.keyboard_arrow_left_sharp,
          // ),
          // moreSelector(
          //     fun: () {
          //       Navigator.push(context, MaterialPageRoute(builder: (context) {
          //         return MyPlacesScreen();
          //       }));
          //     },
          //     icon: Icons.location_pin,
          //     text: "عناويني المحفوظه",
          //     icon2: Icons.keyboard_arrow_left_sharp),
          // moreSelector(
          //     fun: () {
          //       Navigator.push(context, MaterialPageRoute(builder: (context) {
          //         return PayWaysScreen();
          //       }));
          //     },
          //     icon: Icons.add_card_outlined,
          //     text: " طرق الدفع",
          //     icon2: Icons.keyboard_arrow_left_sharp),
          // moreSelector(
          //     fun: () {
          //       Navigator.push(context, MaterialPageRoute(builder: (context) {
          //         return AboutFazzahScreen();
          //       }));
          //     },
          //     icon: Icons.warning_amber_rounded,
          //     text: " عن فزعة",
          //     icon2: Icons.keyboard_arrow_left_sharp),
          // moreSelector(
          //     fun: () {
          //       Navigator.push(context, MaterialPageRoute(builder: (context) {
          //         return PoliciesScreen();
          //       }));
          //     },
          //     icon: Icons.warning,
          //     text: " سياسة الخصوصية",
          //     icon2: Icons.keyboard_arrow_left_sharp),
          // NightMood(
          //   icon2: Icons.toggle_on_outlined,
          //   text: "الوضع الليلي",
          // ),
          // moreSelector(
          //     icon: Icons.exit_to_app_outlined, text: " تسجيل الخروج  "),
          // Padding(
          //   padding: const EdgeInsets.only(left: 260),
          //   child: Text(
          //     "حذف الحساب",
          //     style: TextStyle(color: Colors.red, fontSize: 20),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class MoreSelectWidget extends StatelessWidget {
  const MoreSelectWidget({
    super.key,
    required this.textScreenName,
    this.iconeImage,
    required this.onPressd,
    required this.iconWidget,
  });

  final String textScreenName;
  final String? iconeImage;
  final Function() onPressd;
  final Widget iconWidget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressd,
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(iconeImage ?? ''),
              width10,
              TextWidget(text: textScreenName, textColor: green, textSize: 20),
              const Spacer(),
              iconWidget
            ],
          ),

          //---------- divider -------------
          const Divider(
            color: green,
          )
        ],
      ),
    );
  }
}

class NightMood extends StatelessWidget {
  const NightMood({
    super.key,
    this.text,
    this.icon2,
  });

  final String? text;
  final IconData? icon2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(divide: 1.1),
      height: context.getHeight(divide: 15),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 9, right: 9, left: 9),
                child: Text("$text", style: const TextStyle(fontSize: 20)),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Icon(
                  icon2,
                  size: 30,
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
