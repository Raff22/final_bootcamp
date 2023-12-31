import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/models/payment_method.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/views/user_main_views/more_screens/pay_ways.dart';
import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  final PaymentMethod paymentinfo;
  final VoidCallback onDelete;
  PaymentCard({
    Key? key,
    required this.paymentinfo,
    required this.onDelete,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushScreen(screen: PayWaysScreen());
      },
      child: Container(
          height: context.getHeight(divide: 15),
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
                                ? Image.asset('assets/images/apple_pay.jpg',
                                    fit: BoxFit.cover)
                                : (paymentinfo.name == "Visa" ||
                                        paymentinfo.name == "visa")
                                    ? Image.asset('assets/images/visalogo.jpg',
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
                    Text(" تنتهي في  ${paymentinfo.cardNumber ?? ""} "),
                    Row(
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
              Spacer(),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: onDelete,
              ),
            ],
          )),
    );
  }
}
