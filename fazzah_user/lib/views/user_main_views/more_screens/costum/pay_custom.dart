import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/models/payment_method.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/views/user_main_views/more_screens/pay_ways.dart';
import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  final PaymentMethod paymentinfo;
  final VoidCallback onDelete;
  const PaymentCard({
    Key? key,
    required this.paymentinfo,
    required this.onDelete,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String? cardNumber = paymentinfo.cardNumber ?? "";
    String? lastFourDigits;

    if (cardNumber.length >= 4) {
      lastFourDigits = cardNumber.substring(cardNumber.length - 4);
    } else {
      lastFourDigits = cardNumber;
    }

    String? carEmail = paymentinfo.email ?? "";
    String? firstLetter = carEmail;

    String firstFourChars;
    if (carEmail.length >= 4) {
      firstFourChars = carEmail.substring(0, 4);
    } else {
      firstFourChars = carEmail;
    }

    return InkWell(
      onTap: () {
        context.pushScreen(screen: const PayWaysScreen());
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
            height: context.getHeight(divide: 10),
            width: context.getWidth(divide: 1.1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xffeff0eb),
            ),
            child: Row(
              children: [
                Row(
                  children: [
                    width16,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: SizedBox(
                          height: context.getHeight(divide: 16),
                          width: context.getWidth(divide: 6),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: (paymentinfo.name == "ApplePay")
                                  ? Image.asset('assets/images/apple_pay.png',
                                      fit: BoxFit.cover)
                                  : (paymentinfo.name == "Visa" ||
                                          paymentinfo.name == "visa")
                                      ? Image.asset(
                                          'assets/images/visalogo.png',
                                          fit: BoxFit.fill)
                                      : Image.asset(
                                          'assets/images/paypallogo.png',
                                          fit: BoxFit.contain))),
                    ),
                    width16
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${paymentinfo.cardname}" ?? "",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      // lastFourDigits = cardNumber.substring(cardNumber.length - 4);
                      Text(
                          " البطاقه تنتهي في\n ${paymentinfo.name == "Visa" ? lastFourDigits : firstFourChars} "),

                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text(paymentinfo.email ?? "",
                          //     style: const TextStyle(
                          //         fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text("تنتهي في  ${paymentinfo.expiresAt ?? ""}",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                width32,
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ],
            )),
      ),
    );
  }
}
