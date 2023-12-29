import 'package:cached_network_image/cached_network_image.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/container_widget.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/models/order_model.dart';
import 'package:fazzah_user/models/user_model.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/views/booking_views/tracking_view.dart';
import 'package:flutter/material.dart';

class ProviderOrderCard extends StatelessWidget {
  const ProviderOrderCard({super.key, required this.order, required this.user});
  final UserModel user;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.getWidth(divide: 1.02),
      height: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: TextWidget(text: "${user.name}", textSize: 20),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ContactWidget(icon: Icons.chat, onpressed: () {}),
                width20,
                ContactWidget(icon: Icons.phone, onpressed: () {}),
              ],
            ),
          ),
          height10,
          ContainerWidget(
              contanierBorderRadius: 10,
              containerWidth: context.getWidth(),
              containerHeight: 48,
              containerColor: green,
              onPressed: () {},
              child: const Center(
                  child: TextWidget(
                text: "تفاصيل الطلب",
                textSize: 25,
                textColor: lightGrey,
              ))),
        ],
      ),
    );
  }
}
