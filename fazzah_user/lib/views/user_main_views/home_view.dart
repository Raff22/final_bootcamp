import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/views/user_main_views/coustom_wedgets/user_wedgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.only(left: 250, top: 50),
            child: Text(" اهلا ,نوره",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
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
          Padding(
            padding: EdgeInsets.only(left: 300),
            child: Text("خدماتنا",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  kdmatWedget(img: "assets/images/imgg1.png", text: "سباكة"),
                  SizedBox(width: 10),
                  kdmatWedget(
                      img: "assets/images/electric.png", text: "كهرباء"),
                  SizedBox(width: 10),
                  kdmatWedget(img: "assets/images/imgg1.png", text: "تركيب"),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 10,
              left: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("اقرب الفنيين لك",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Colors.black)),
                Text("عرض الكل",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Colors.black)),
              ],
            ),
          ),
          SizedBox(height: 10),
          WorkerCard(
            name: " نور احمد",
            rate: "4.5",
            ratenum: "(100 تقييم)",
            profileimg: "assets/images/personimg.png",
            peice: "100-150",
          ),
        ],
      ),
    );
  }
}
