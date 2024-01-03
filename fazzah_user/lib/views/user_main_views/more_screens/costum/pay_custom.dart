import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
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
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
            height: context.getHeight(divide: 10),
            width: context.getWidth(divide: 1.2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xffeff0eb),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                children: [
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
                                    ? Image.asset('assets/images/visalogo.png',
                                        fit: BoxFit.fill)
                                    : Image.asset(
                                        'assets/images/paypallogo.png',
                                        fit: BoxFit.contain))),
                  ),
                  width10,
                  SizedBox(
                    width: context.getWidth(divide: 1.80),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          paymentinfo.cardname != null
                              ? Text("${paymentinfo.cardname}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold))
                              : const Text(""),
                          // lastFourDigits = cardNumber.substring(cardNumber.length - 4);
                          // Text(
                          //     " البطاقه تنتهي في\n ${paymentinfo.name == "Visa" ? lastFourDigits : firstFourChars} "),

                          // const Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          // Text(paymentinfo.email ?? "",
                          //     style: const TextStyle(
                          //         fontSize: 20, fontWeight: FontWeight.bold)),
                          //   ],
                          // ),
                          Row(
                            children: [
                              const TextWidget(text: 'البطاقة تنتهي في '),
                              Text(paymentinfo.expiresAt ?? "2026",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Text("تنتهي في  ${paymentinfo.expiresAt ?? ""}",
                  //     style: const TextStyle(
                  //         fontSize: 14, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: onDelete,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
