import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/views/auth_views/auth_widget/logo_widget.dart';
import 'package:fazzah_user/views/auth_views/auth_widget/title_view.dart';
import 'package:flutter/material.dart';

class SignupProviderView extends StatelessWidget {
  SignupProviderView({super.key});

  // final _formField = GlobalKey<FormState>();
  // final TextEditingController fullNameController = TextEditingController();
  // final TextEditingController nationalIdController = TextEditingController();
  // final TextEditingController phoneNumberController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();
  // final TextEditingController nationaltyController = TextEditingController();
  // final TextEditingController occupationController = TextEditingController();
  // final TextEditingController yearsOfExperienceController = TextEditingController();

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
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ------------------------ Logo ---------------------------
                    const LogoWidget(
                      pathImage: 'assets/images/Logo_provider.png',
                    ),
                    height20,

                    //--------------------- Login Title  ------------------------
                    const TitleView(
                      title: 'إنشاء حساب',
                      supTitle: 'خطوات بسيطة ويكون حسابك جاهز',
                    ),
                    height20,

                    //---------------- upload provider image -------------------
                    

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
