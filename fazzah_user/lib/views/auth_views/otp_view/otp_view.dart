import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/container_widget.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/views/auth_views/auth_widget/logo_widget.dart';
import 'package:fazzah_user/views/auth_views/auth_widget/title_view.dart';
import 'package:fazzah_user/views/auth_views/otp_view/otp_widget/otp_text_field.dart';
import 'package:flutter/material.dart';

class OtpView extends StatelessWidget {
  OtpView({super.key, required this.email, required this.password});
  final _formField = GlobalKey<FormState>();
  final String email;
  final String password;

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
                    const TitleView(
                      title: 'إنشاء حساب',
                      supTitle: 'خطوات بسيطة ويكون حسابك جاهز',
                    ),
                    height20,

                    // ------------------  OTP Text Field  ---------------------

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OtpTextField(),
                        OtpTextField(),
                        OtpTextField(),
                        OtpTextField(),
                      ],
                    ),
                    height20,
                    // --------------  Container (تسجيل دخول)  ---------------

                    ContainerWidget(
                      containerHeight: 48,
                      containerWidth: context.getWidth(),
                      containerColor: grey,
                      //  emailController.text.isNotEmpty ||
                      //         passwordController.text.isNotEmpty ||
                      //         fullNameController.text.isNotEmpty ||
                      //         phoneNumberController.text.isNotEmpty
                      //     ? green
                      //     : grey,
                      contanierBorderRadius: 10,
                      onPressed: () {
                        //----------------------------------------------
                        if (_formField.currentState!.validate()) {
                          print('Succecc Otp');
                        }
                        //------------------- Send data to database using bloc ---------------------
                      },
                      child: const Center(
                        child: TextWidget(
                            text: 'إنشاء حساب', textSize: 20, textColor: black
                            //  emailController.text.isNotEmpty ||
                            //         passwordController.text.isNotEmpty ||
                            //         fullNameController.text.isNotEmpty ||
                            //         phoneNumberController.text.isNotEmpty
                            //     ? white
                            //     : black,
                            ),
                      ),
                    ),
                    height10,

                    //--------------------- Resend OTP -----------------------
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
