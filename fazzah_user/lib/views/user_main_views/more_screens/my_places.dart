import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/container_widget.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/models/user_model.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/views/user_main_views/more_screens/add_place.dart';
import 'package:flutter/material.dart';

class MyPlacesScreen extends StatelessWidget {
  const MyPlacesScreen({super.key,required this.user});
    final UserModel user;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(
          context: context,
          title: 'عناويني',
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                context.popScreen();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded))),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            ContainerWidget(
              contanierBorderRadius: 10,
              containerWidth: context.getWidth(),
              containerColor: lightGreen,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextWidget(text: 'عنوان الموقع '),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.delete))
                      ],
                    ),
                    const TextWidget(
                        text:
                            'kjsfbvljkfbvlka kufgksdhvgnkfhbkjbvhlgfhbksh vjhfgkjhdbvhgvbbn bgjskdfbgndsakjdfbgcmdskjfbgnvfnarehtbfsjdghxr5ahafrsvrarajafarvdgsrasjsfrdhbgbv s'),
                    height20
                  ],
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                context.pushScreen(screen: AddPlaceScreen(user: user,));
              },
              child: ContainerWidget(
                containerHeight: 48,
                containerWidth: context.getWidth(),
                contanierBorderRadius: 10,
                containerColor: green,
                child: const Center(
                  child: TextWidget(
                    text: 'إضافة عنوان',
                    textColor: white,
                    textSize: 20,
                  ),
                ),
              ),
            ),
            height20
          ],
        ),
      ),
    );
  }
}
