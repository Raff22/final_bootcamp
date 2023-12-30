import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:flutter/material.dart';

class PoliciesScreen extends StatelessWidget {
  const PoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(
          context: context,
          title: 'سياسة الخصوصية',
          centerTitle: true,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              height20,
              SizedBox(
                width: context.getWidth(divide: 4),
                child: Image.asset("assets/images/Logo.png"),
              ),
              height20,
              SizedBox(
                width: context.getWidth(divide: 1.2),
                child: const TextWidget(
                    text:
                        "عندما تستخدم فزعة ، فأنت تثق بنا في بياناتك الشخصية. نحن ملتزمون بالحفاظ على هذه الثقه . يبدأ ذلك بمساعدتك على فهم ممارسات الخصوصية لدينا. توضح سياسة الخصوصية بموجبها قواعد فزعة فيما يتعلق بجمع البيانات الشخصية و استخدامها"),
              ),
              height20,
              SizedBox(
                width: context.getWidth(divide: 1.2),
                child: const TextWidget(
                  text: 'كيف نستخدم معلوماتك الشخصية؟',
                  textFontWeight: FontWeight.bold,
                  textSize: 18,
                ),
              ),
              height20,
              SizedBox(
                  width: context.getWidth(divide: 1.2),
                  child: Text(
                      "لتحسين تجربة المستخدم - قد نستخدم المعلومات التي نجمعها بهدف دراسة كيفية استخدام التطبيق بشكل اجمالي و تسهل علينا من معرفة حاجات المستخدمين كمجموعة و بالتالي تحسين الخصائص المقدمة لهم.")),
            ],
          ),
        ),
      ),
    );
  }
}
