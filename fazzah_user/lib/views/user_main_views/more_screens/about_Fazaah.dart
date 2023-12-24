import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/views/user_main_views/coustom_wedgets/user_wedgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AboutFazzahScreen extends StatelessWidget {
  const AboutFazzahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          mainScreenAppbar(
            title: " ",
            iconleft: Icons.ios_share_rounded,
            iconrisht: Icons.arrow_back_ios_new_rounded,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: context.getWidth(divide: 4),
            height: context.getHeight(divide: 5),
            child: Image.asset("assets/images/Logo.png"),
          ),
          SizedBox(
            width: context.getWidth(divide: 1.2),
            height: context.getHeight(divide: 5),
            child: Text(
                "فزعة هي منصة الكترونية متقدمة تربط بين مقدمي فني صيانة منزلية و المستخدم . من خلال انظمة الادارة التفاعلية يتيح فزعة للمستخدم سهولة تصفح قوائم الخدمات و الفنيين و اختيار الفني و طلبه ، كما يوفر النظام امكانية تتبع الفني ،بالاضافة الى امكانية التواصل مع الفني مباشرة اذا دعت الحاجه"),
          )
        ],
      ),
    );
  }
}
