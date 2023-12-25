import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/views/user_main_views/coustom_wedgets/user_wedgets.dart';
import 'package:fazzah_user/views/user_main_views/more_screens/about_Fazaah.dart';
import 'package:fazzah_user/views/user_main_views/more_screens/my_account.dart';
import 'package:fazzah_user/views/user_main_views/more_screens/my_places.dart';
import 'package:fazzah_user/views/user_main_views/more_screens/pay_ways.dart';
import 'package:fazzah_user/views/user_main_views/more_screens/polcies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          mainScreenAppbar(title: "المزيد"),
          SizedBox(
            height: 20,
          ),
          moreSelector(
            fun: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyAccountScreen();
              }));
            },
            icon: Icons.person,
            text: "حسابي",
            icon2: Icons.keyboard_arrow_left_sharp,
          ),
          moreSelector(
              fun: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyPlacesScreen();
                }));
              },
              icon: Icons.location_pin,
              text: "عناويني المحفوظه",
              icon2: Icons.keyboard_arrow_left_sharp),
          moreSelector(
              fun: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PayWaysScreen();
                }));
              },
              icon: Icons.add_card_outlined,
              text: " طرق الدفع",
              icon2: Icons.keyboard_arrow_left_sharp),
          moreSelector(
              fun: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AboutFazzahScreen();
                }));
              },
              icon: Icons.warning_amber_rounded,
              text: " عن فزعة",
              icon2: Icons.keyboard_arrow_left_sharp),
          moreSelector(
              fun: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PoliciesScreen();
                }));
              },
              icon: Icons.warning,
              text: " سياسة الخصوصية",
              icon2: Icons.keyboard_arrow_left_sharp),
          NightMood(
            icon2: Icons.toggle_on_outlined,
            text: "الوضع الليلي",
          ),
          moreSelector(
              icon: Icons.exit_to_app_outlined, text: " تسجيل الخروج  "),
          Padding(
            padding: const EdgeInsets.only(left: 260),
            child: Text(
              "حذف الحساب",
              style: TextStyle(color: Colors.red, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class moreSelector extends StatelessWidget {
  const moreSelector({
    super.key,
    this.icon,
    this.text,
    this.icon2,
    this.fun,
  });
  final IconData? icon;
  final String? text;
  final IconData? icon2;
  final Function? fun;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        fun!();
      },
      child: Container(
        width: context.getWidth(divide: 1.1),
        height: context.getHeight(divide: 15),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Icon(icon),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 9, right: 9, left: 9),
                  child: Text(
                    "$text",
                    style: TextStyle(fontSize: 20, color: Color(0xff2C5602)),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Icon(icon2, color: Color(0xff2C5602)),
                ),
              ],
            ),
            Divider(
              color: Colors.black,
            )
          ],
        ),
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
                child: Text("$text", style: TextStyle(fontSize: 20)),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Icon(
                  icon2,
                  size: 30,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
