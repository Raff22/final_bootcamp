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
              onPressed: () {
                showBottomSheet(
                    backgroundColor: white,
                    enableDrag: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextWidget(
                                text: "تفاصيل الطلب",
                                textSize: 22,
                                textFontWeight: FontWeight.w600,
                              ),
                              const Divider(),
                              const TextWidget(
                                  text: "معلومات الحجز",
                                  textSize: 22,
                                  textFontWeight: FontWeight.w500),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const TextWidget(
                                        text: "اسم المستخدم", textSize: 17),
                                    TextWidget(
                                        text: "${user.name}", textSize: 17),
                                  ]),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const TextWidget(
                                        text: "تاريخ الطلب", textSize: 17),
                                    TextWidget(
                                        text: "${order.orderDate}",
                                        textSize: 17),
                                  ]),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const TextWidget(
                                        text: "وقت الحجز", textSize: 17),
                                    TextWidget(
                                        text: "${order.orderTime}",
                                        textSize: 17),
                                  ]),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const TextWidget(
                                        text: "نوع الطلب", textSize: 17),
                                    TextWidget(
                                        text: "${order.orderType}",
                                        textSize: 17),
                                  ]),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const TextWidget(
                                        text: "حالة الطلب", textSize: 17),
                                    TextWidget(
                                        text: "${order.orderStatus}",
                                        textSize: 17),
                                  ]),
                              height50,
                              const Divider(),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const TextWidget(
                                        text: "المجموع", textSize: 17),
                                    TextWidget(
                                        text: "${order.total}", textSize: 17),
                                  ]),
                              height20,
                              Center(
                                child: ContainerWidget(
                                    contanierBorderRadius: 10,
                                    containerWidth: 366,
                                    containerHeight: 48,
                                    containerColor: green,
                                    onPressed: () {},
                                    child: const Center(
                                        child: TextWidget(
                                      text: "تتبع الموقع",
                                      textSize: 25,
                                      textColor: lightGrey,
                                    ))),
                              ),
                            ]),
                      );
                    });
              },
              child: const Center(
                  child: TextWidget(
                text: "تفاصيل الطلب",
                textSize: 20,
                textColor: lightGrey,
              ))),
        ],
      ),
    );
  }
}