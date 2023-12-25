import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/views/user_main_views/coustom_wedgets/user_wedgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PoliciesScreen extends StatelessWidget {
  const PoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          mainScreenAppbar(
            title: "سياسة الخصوصيه ",
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
            height: context.getHeight(divide: 6),
            child: Text(
                "عندما تستخدم فزعة ، فأنت تثق بنا في بياناتك الشخصية. نحن ملتزمون بالحفاظ على هذه الثقه . يبدأ ذلك بمساعدتك على فهم ممارسات الخصوصية لدينا. توضح سياسة الخصوصية بموجبها قواعد فزعة فيما يتعلق بجمع البيانات الشخصية و استخدامها"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100),
            child: Text(
              "كيف نستخدم معلوماتك الشخصية؟",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          SizedBox(
              width: context.getWidth(divide: 1.2),
              height: context.getHeight(divide: 6),
              child: Text(
                  "لتحسين تجربة المستخدم - قد نستخدم المعلومات التي نجمعها بهدف دراسة كيفية استخدام التطبيق بشكل اجمالي و تسهل علينا من معرفة حاجات المستخدمين كمجموعة و بالتالي تحسين الخصائص المقدمة لهم.")),
        ],
      ),
    );
  }
}
