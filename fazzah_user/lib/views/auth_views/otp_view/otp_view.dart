// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:fazzah_user/bloc/auth_bloc/auth_bloc.dart';
import 'package:fazzah_user/bloc/auth_bloc/auth_event.dart';
import 'package:fazzah_user/bloc/auth_bloc/auth_state.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/container_widget.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/loading_func.dart';
import 'package:fazzah_user/utils/helpers/snackbar_mess.dart';
import 'package:fazzah_user/views/auth_views/auth_widget/logo_widget.dart';
import 'package:fazzah_user/views/auth_views/auth_widget/title_view.dart';
import 'package:fazzah_user/views/auth_views/otp_view/otp_widget/otp_text_field.dart';
import 'package:fazzah_user/views/auth_views/user_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

class OtpView extends StatefulWidget {
  OtpView({
    super.key,
    required this.email,
  });
  final String email;

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final _formField = GlobalKey<FormState>();
  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();
  TextEditingController pin3 = TextEditingController();
  TextEditingController pin4 = TextEditingController();
  TextEditingController pin5 = TextEditingController();
  TextEditingController pin6 = TextEditingController();
  int secondsRemaining = 30;
  bool enableResend = false;
  late Timer timer;
  @override
  initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.arrow_back_ios_rounded),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 100,
              ),
              child: Form(
                key: _formField,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ------------------------ Logo ---------------------------
                    const LogoWidget(
                      pathImage: 'assets/images/Logo.png',
                    ),
                    height20,

                    //--------------------- Login Title  -----------------------
                    TitleView(
                      title: 'إنشاء حساب',
                      supTitle: 'تم إرسال رمز التحقق إلى ${widget.email}',
                    ),
                    height20,

                    // ------------------  OTP Text Field  ---------------------

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OtpTextField(
                          pin: pin1,
                        ),
                        OtpTextField(
                          pin: pin2,
                        ),
                        OtpTextField(
                          pin: pin3,
                        ),
                        OtpTextField(
                          pin: pin4,
                        ),
                        OtpTextField(
                          pin: pin5,
                        ),
                        OtpTextField(
                          pin: pin6,
                        ),
                      ],
                    ),
                    height10,

                    //--------------------- Resend OTP -----------------------
                    OtpTimerButton(
                      onPressed: () {
                        snackBarMassage(
                            context: context,
                            snackBarText:
                                'تم ارسال رمز التحقق  مرة أخرى الى البريد الإلكتروني ${widget.email}');

                        context.read<AuthBloc>().add(ResendOTPEvent(
                              email: widget.email,
                            ));
                      },
                      text: const Text('Resend OTP'),
                      duration: 30,
                    ),

                    // --------------  Container (تسجيل دخول)  ---------------

                    BlocListener<AuthBloc, AuthStatee>(
                      //--------------- listener function ----------------------
                      listener: (context, state) {
                        // ------------- Loading State --------------
                        if (state is LoadingAuthState) {
                          showLoadingDialog(context: context);
                        }

                        // ------------ OTP Successed State -----------
                        else if (state is OTPSuccessedState) {
                          context.removeUnitl(screen: const UserHomePage());

                          pin1.clear();
                          pin2.clear();
                          pin3.clear();
                          pin4.clear();
                          pin5.clear();
                          pin6.clear();
                        }

                        // -------- OTP Error State ---------
                        else if (state is ErrorAuthState) {
                          context.popScreen();
                          snackBarMassage(
                              context: context, snackBarText: state.message);
                        }
                      },

                      //------------------ listener widget ---------------------
                      child: ContainerWidget(
                        containerHeight: 48,
                        containerWidth: context.getWidth(),
                        containerColor: pin1.text.isNotEmpty ||
                                pin2.text.isNotEmpty ||
                                pin3.text.isNotEmpty ||
                                pin4.text.isNotEmpty ||
                                pin5.text.isNotEmpty ||
                                pin6.text.isNotEmpty
                            ? green
                            : grey,
                        contanierBorderRadius: 10,
                        onPressed: () {
                          // ------ 1) check if all field is empty or not ------
                          if (pin1.text.isEmpty ||
                              pin2.text.isEmpty ||
                              pin3.text.isEmpty ||
                              pin4.text.isEmpty ||
                              pin5.text.isEmpty ||
                              pin6.text.isEmpty) {
                            snackBarMassage(
                                context: context,
                                snackBarText: 'رجاءََ قم بتعبئة جميع الخانات');
                          }

                          // ------ 2) check if validate is all good ------
                          // ------- and send the event otp to Auth Bloc -------
                          else if (_formField.currentState!.validate()) {
                            final String otp = pin1.text +
                                pin2.text +
                                pin3.text +
                                pin4.text +
                                pin5.text +
                                pin6.text;
                            print(otp);
                            print('Succecc Otp');
                            context.read<AuthBloc>().add(OTPEvent(
                                  otp: otp,
                                  email: widget.email,
                                ));
                          }
                        },
                        child: Center(
                          child: TextWidget(
                            text: 'إنشاء حساب',
                            textSize: 20,
                            textColor: pin1.text.isNotEmpty ||
                                    pin2.text.isNotEmpty ||
                                    pin3.text.isNotEmpty ||
                                    pin4.text.isNotEmpty ||
                                    pin5.text.isNotEmpty ||
                                    pin6.text.isNotEmpty
                                ? white
                                : black,
                          ),
                        ),
                      ),
                    ),
                    height10,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _resendCode() {
    //other code here
    setState(() {
      secondsRemaining = 30;
      enableResend = false;
    });
  }

  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }
}
