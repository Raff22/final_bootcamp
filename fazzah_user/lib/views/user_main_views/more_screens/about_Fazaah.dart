import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:flutter/material.dart';

class AboutFazzahScreen extends StatelessWidget {
  const AboutFazzahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(
          context: context,
          title: 'عن فزعة',
          centerTitle: true,
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.ios_share_rounded,
              size: 25,
            ),
          ),
          leading: IconButton(
              onPressed: () {
                context.popScreen();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded))),
      body: SizedBox(
        height: context.getHeight(),
        width: context.getWidth(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              SizedBox(
                width: context.getWidth(divide: 4),
                child: Image.asset("assets/images/Logo.png"),
              ),
              height20,
              SizedBox(
                width: context.getWidth(divide: 1.2),
                child: const Text(
                    "فزعة هي منصة الكترونية متقدمة تربط بين مقدمي فني صيانة منزلية و المستخدم . من خلال انظمة الادارة التفاعلية يتيح فزعة للمستخدم سهولة تصفح قوائم الخدمات و الفنيين و اختيار الفني و طلبه ، كما يوفر النظام امكانية تتبع الفني ،بالاضافة الى امكانية التواصل مع الفني مباشرة اذا دعت الحاجه"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
