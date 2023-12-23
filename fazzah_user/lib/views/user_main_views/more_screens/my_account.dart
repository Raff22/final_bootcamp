import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/views/user_main_views/coustom_wedgets/user_wedgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          mainScreenAppbar(
              title: "حسابي", iconrisht: Icons.arrow_back_ios_new_outlined),
          Padding(
            padding: EdgeInsets.all(30),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  hintText: "اسم المستخدم",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: TextField(
              decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.phone,
                    color: Colors.grey,
                  ),
                  hintText: "رقم الجوال",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
          Container(
            width: context.getWidth(divide: 1.2),
            height: context.getHeight(divide: 16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(11)),
            ),
            child: Center(
              child: Text(
                "تحديث الحساب",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
          )
        ],
      ),
    );
  }
}
