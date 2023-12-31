import 'package:fazzah_user/app_data/static_data.dart';
import 'package:fazzah_user/constant/color.dart';

import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/models/payment_method.dart';
import 'package:flutter/material.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget(
      {super.key, required this.method, this.showAdd = true});
  final PaymentMethod method;
  final bool showAdd;

  @override
  Widget build(BuildContext context) {
    String title = '';
    if (method.name! == 'paypal' || method.name! == 'PayPal') {
      title = method.email!;
    } else if (method.name! == 'visa' || method.name! == 'Visa') {
      title = method.cardNumber!;
    }
    return ListTile(
      leading: Image.asset(paymentMap[method.name!]!, height: 36),
      title: TextWidget(text: title),
      subtitle: TextWidget(text: method.expiresAt ?? ""),
      trailing: showAdd
          ? Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: green, borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.add,
                size: 20,
                color: white,
              ))
          : null,
    );
  }
}
