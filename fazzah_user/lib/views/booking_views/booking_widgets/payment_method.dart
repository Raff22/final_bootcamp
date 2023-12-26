import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/container_widget.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:flutter/material.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        height: 58,
        decoration: BoxDecoration(
            border: Border.all(color: grey),
            borderRadius: BorderRadius.circular(10)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          //HERE PAYMENT METHOD OBJECT
          Image.asset('assets/images/applepay.png'),
          InkWell(
            onTap: () {
              showBottomSheet(
                  context: context,
                  backgroundColor: white,
                  builder: (context) {
                    return SizedBox(
                      height: context.getHeight(divide: 3),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
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
                                    text: "تغيير",
                                    textSize: 25,
                                    textColor: lightGrey,
                                  ))),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              width: 49,
              height: 36,
              decoration: BoxDecoration(
                  color: green, borderRadius: BorderRadius.circular(10)),
              child: const TextWidget(text: "تغيير", textColor: white),
            ),
          )
        ]));
  }
}
