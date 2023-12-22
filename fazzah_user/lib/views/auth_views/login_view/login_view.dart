// ignore_for_file: must_be_immutable

import 'package:fazzah_user/bloc/is_provider/is_provider_cubit.dart';
import 'package:fazzah_user/bloc/visible_password/visible_password_cubit.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/container_widget.dart';
import 'package:fazzah_user/global/global_widget/text_form_field_widget.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/format_checkers/format_checks.dart';
import 'package:fazzah_user/views/auth_views/auth_widget/login_or_sign_up_widget.dart';
import 'package:fazzah_user/views/auth_views/auth_widget/logo_widget.dart';
import 'package:fazzah_user/views/auth_views/auth_widget/title_view.dart';
import 'package:fazzah_user/views/auth_views/signup_view/signup_provider_view/signup_provider_view.dart';
import 'package:fazzah_user/views/auth_views/signup_view/signup_user_view/signup_user_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formField = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 100,
              ),
              child: BlocBuilder<IsProviderCubit, bool>(
                builder: (context, stateUser) {
                  return Form(
                    key: _formField,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // ------------------------ Logo ---------------------------
                        LogoWidget(
                          pathImage: stateUser
                              ? 'assets/images/Logo_provider.png'
                              : 'assets/images/Logo.png',
                        ),

                        //---------------- text for provider only ------------------

                        height4,
                        TextWidget(
                          text: stateUser ? 'فزعة للفنين' : '',
                          textSize: 20,
                          textColor: dark1Green,
                        ),
                        height20,

                        //--------------------- Login Title  ------------------------
                        const TitleView(
                          title: 'تسجيل الدخول',
                          supTitle:
                              'الرجاء إدخال البريد الإلكتروني والرقم السري',
                        ),
                        height20,

                        // ----------------- Text Filed Email ----------------------
                        TextFormFieldWidget(
                          validator: (value) {
                            bool emailValid =
                                FormatCheck().checkEmailFormat(value!);
                            if (value.isEmpty) {
                              return 'رجاءََ أدخل بريدك الإلكتروني';
                            } else if (!emailValid) {
                              return 'رجاءََ أدخل بريدك الإلكتروني بشكل صحيح';
                            }
                            return '';
                          },
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: grey,
                          controller: emailController,
                          labelText: 'البريد الإلكتروني',
                          labelTextColor: grey,
                          controllerTextColor: dark1Green,
                          prefixIcon: const Icon(
                            Icons.email,
                            color: grey,
                          ),
                        ),
                        height20,

                        // ----------------- Text Filed Password -------------------

                        BlocBuilder<VisiblePasswordCubit, bool>(
                          builder: (context, statePassword) {
                            return TextFormFieldWidget(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'رجاءََ أدخل الرقم السري';
                                }
                                return '';
                              },
                              obscureText: !statePassword ? true : false,
                              keyboardType: TextInputType.visiblePassword,
                              cursorColor: grey,
                              controller: passwordController,
                              labelText: 'الرقم السري',
                              labelTextColor: grey,
                              controllerTextColor: dark1Green,
                              prefixIcon: IconButton(
                                icon: Icon(
                                  !statePassword
                                      ? Icons.lock_outline_rounded
                                      : Icons.lock_open_outlined,
                                  color: grey,
                                ),
                                onPressed: () {
                                  context
                                      .read<VisiblePasswordCubit>()
                                      .isVisiblePassword(statePassword);
                                },
                              ),
                            );
                          },
                        ),
                        height20,

                        // --------------  Container (تسجيل دخول)  ---------------

                        ContainerWidget(
                          containerHeight: 48,
                          containerWidth: context.getWidth(),
                          containerColor: grey,
                          contanierBorderRadius: 10,
                          onPressed: () {
                            if (_formField.currentState!.validate()) {
                              print('Succecc Login');
                              emailController.clear();
                              passwordController.clear();
                            }
                          },
                          child: const Center(
                            child: TextWidget(
                              text: 'تسجيل دخول',
                              textSize: 20,
                            ),
                          ),
                        ),
                        height10,

                        // --------------------  Row Text  ----------------------

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //------------------ Provider or User ------------------

                            InkWell(
                              onTap: () {
                                context
                                    .read<IsProviderCubit>()
                                    .isProvider(stateUser);
                              },
                              child: TextWidget(
                                text: stateUser
                                    ? 'هل انت مستخدم ؟'
                                    : 'هل انت فني ؟',
                              ),
                            ),

                            //------------------ Create Account ------------------

                            LoginOrSignupWidget(
                              askText: 'لا تمتلك حساب ؟',
                              textButtom: 'إنشاء حساب',
                              navigatorTo: () {
                                stateUser
                                    ? context.pushScreen(
                                        screen: SignupProviderView())
                                    : context.pushScreen(
                                        screen: SignupUserView());
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
