import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> list = [
      "assets/images/AD.png",
      "assets/images/AD-2.png",
      "assets/images/AD-3.png",
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_ios_outlined,
                size: 20, color: black)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        )),
        foregroundColor: black,
        backgroundColor: lightGreen,
        title: TextWidget(
          text: 'user_type_screen.userSelection1'.tr(),
          textSize: 28,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.only(left: 250, top: 50),
            child: Text("hello Fisal"),
          ),
          Container(
              child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
            items: list
                .map((item) => Container(
                      child: Center(child: Image.asset(item.toString())),
                      color: Colors.white,
                    ))
                .toList(),
          )),
          Row(
            children: [],
          )
        ],
      ),
    );
  }
}
