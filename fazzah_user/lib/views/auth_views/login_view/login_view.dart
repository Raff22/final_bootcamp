// ignore_for_file: must_be_immutable

import 'package:fazzah_user/bloc/visible_password/visible_password_cubit.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final emailKey = GlobalKey<FormState>();

  final passwordKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  bool passToggle = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: context.getHeight(),
        width: context.getWidth(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Logo.png',
                height: 137,
                width: 137.84,
              ),
              SizedBox(
                width: context.getWidth(),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextWidget(
                      text: 'تسجيل الدخول',
                      textSize: 34,
                    )
                  ],
                ),
              ),
              TextFormField(
                style: const TextStyle(color: dark1Green),
                cursorColor: grey,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  // contentPadding: const EdgeInsets.only(left: 10),
                  label: const TextWidget(
                    text: 'البريد الإلكتروني',
                    textAlign: TextAlign.right,
                    textColor: grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: grey),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: grey),
                      borderRadius: BorderRadius.circular(10)),
                  suffixIcon: const Icon(
                    Icons.email,
                    color: grey,
                  ),
                ),
              ),
              height20,
              BlocBuilder<VisiblePasswordCubit, bool>(
                builder: (context, state) {
                  return TextFormField(
                    obscureText: !state ? true : false,
                    style: const TextStyle(color: dark1Green),
                    cursorColor: grey,
                    keyboardType: TextInputType.emailAddress,
                    controller: passwordController,
                    decoration: InputDecoration(
                      floatingLabelAlignment: FloatingLabelAlignment.center,
                      //contentPadding: const EdgeInsets.only(left: 10),
                      label: const TextWidget(
                        text: 'الرقم السري',
                        textAlign: TextAlign.right,
                        textColor: grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: grey),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: grey),
                          borderRadius: BorderRadius.circular(10)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          !state
                              ? Icons.lock_outline_rounded
                              : Icons.lock_open_outlined,
                          color: grey,
                        ),
                        onPressed: () {
                          context
                              .read<VisiblePasswordCubit>()
                              .isVisiblePassword(state);
                        },
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
