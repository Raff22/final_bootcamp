import 'package:fazzah_user/app_data/static_data.dart';
import 'package:fazzah_user/constant/color.dart';

import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/models/payment_method.dart';
import 'package:flutter/material.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({
    super.key,
    required this.method,
    required this.showOnTap,
  });
  final PaymentMethod method;
  final bool showOnTap;

  @override
  Widget build(BuildContext context) {
    // return Container(
    //     padding: const EdgeInsets.all(8),
    //     height: 58,
    //     decoration: BoxDecoration(
    //         border: Border.all(color: grey),
    //         borderRadius: BorderRadius.circular(10)),
    //     child:
    //         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    //       getPaymentInfo(),
    //     ]));
    return getPaymentInfo();
  }

  Widget getPaymentInfo() {
    String title = '';
    if (method.name! == 'paypal') {
      title = method.email!;
    } else if (method.name! == 'visa') {
      title = method.cardNumber!.toString();
    }
    return ListTile(
      leading: Image.asset(paymentMap[method.name!]!, height: 36),
      title: TextWidget(text: title),
      trailing: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: green, borderRadius: BorderRadius.circular(10)),
          child: const Icon(
            Icons.add,
            size: 20,
            color: white,
          )),
    );
  }
}
