import 'package:fazzah_user/bloc/auth_bloc/auth_bloc.dart';
import 'package:fazzah_user/bloc/auth_bloc/auth_event.dart';
import 'package:fazzah_user/bloc/auth_bloc/auth_state.dart';
import 'package:fazzah_user/bloc/visible_password_cubit/visible_password_cubit.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/container_widget.dart';
import 'package:fazzah_user/global/global_widget/text_form_field_widget.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/format_checkers/format_checks.dart';
import 'package:fazzah_user/utils/helpers/loading_func.dart';
import 'package:fazzah_user/utils/helpers/snackbar_mess.dart';
import 'package:fazzah_user/views/auth_views/auth_widget/login_or_sign_up_widget.dart';
import 'package:fazzah_user/views/auth_views/auth_widget/logo_widget.dart';
import 'package:fazzah_user/views/auth_views/auth_widget/title_view.dart';
import 'package:fazzah_user/views/auth_views/login_view/login_view.dart';
import 'package:fazzah_user/views/auth_views/otp_view/otp_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupUserView extends StatelessWidget {
  SignupUserView({super.key});

  final _formField = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

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

                    // ----------------- Text Field Full Name ------------------
                    TextFormFieldWidget(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'رجاءََ أدخل اسمك الثلاثي';
                        }
                        return null;
                      },
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      cursorColor: grey,
                      controller: fullNameController,
                      labelText: 'الإسم الثلاثي',
                      labelTextColor: grey,
                      controllerTextColor: dark1Green,
                      suffixIcon: const Icon(
                        Icons.person_rounded,
                        color: grey,
                      ),
                    ),
                    height20,

                    // ----------------- Text Field Email ----------------------
                    TextFormFieldWidget(
                      validator: (value) {
                        bool emailValid =
                            FormatCheck().checkEmailFormat(value!);
                        if (value.isEmpty) {
                          return 'رجاءََ أدخل بريدك الإلكتروني';
                        } else if (!emailValid) {
                          return 'رجاءََ أدخل بريدك الإلكتروني بشكل صحيح';
                        }
                        return null;
                      },
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: grey,
                      controller: emailController,
                      labelText: 'البريد الإلكتروني',
                      labelTextColor: grey,
                      controllerTextColor: dark1Green,
                      suffixIcon: const Icon(
                        Icons.email,
                        color: grey,
                      ),
                    ),
                    height20,

                    // ----------------- Text Field Password -------------------

                    BlocBuilder<VisiblePasswordCubit, bool>(
                      builder: (context, statePassword) {
                        return TextFormFieldWidget(
                          validator: (value) {
                            bool passwordValid =
                                FormatCheck().checkPasswordLength(value!);
                            if (value.isEmpty) {
                              return 'رجاءََ أدخل الرقم السري';
                            } else if (!passwordValid) {
                              return 'يجب ان يكون الرقم السري أكثر من 6 خانات';
                            }
                            return null;
                          },
                          obscureText: !statePassword ? true : false,
                          keyboardType: TextInputType.visiblePassword,
                          cursorColor: grey,
                          controller: passwordController,
                          labelText: 'الرقم السري',
                          labelTextColor: grey,
                          controllerTextColor: dark1Green,
                          suffixIcon: IconButton(
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

                    // ----------------- Text Field Pnone Number ---------------

                    TextFormFieldWidget(
                      validator: (value) {
                        bool phoneValid = FormatCheck().checkPhone(value!);
                        if (value.isEmpty) {
                          return 'رجاءََ أدخل رقم الهاتف';
                        } else if (!phoneValid) {
                          return '05xxxxxxxxx يجب ان يكون رقم الهاتف عشر أرقام ويبدا ب';
                        }
                        return null;
                      },
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                      cursorColor: grey,
                      controller: phoneNumberController,
                      labelText: 'رقم الهاتف',
                      labelTextColor: grey,
                      controllerTextColor: dark1Green,
                      suffixIcon: const Icon(
                        Icons.phone,
                        color: grey,
                      ),
                    ),
                    height20,

                    // --------------  Container (تسجيل دخول)  ---------------

                    BlocListener<AuthBloc, AuthStatee>(
                      //--------------- listener function ----------------------
                      listener: (context, state) {
                        // ------------- Loading State --------------
                        if (state is LoadingAuthState) {
                          showLoadingDialog(context: context);
                        }

                        // -------- Sign Up Successed State ---------
                        else if (state is SignUpSuccessedState) {
                          context.removeUnitl(
                              screen: OtpView(
                            password: passwordController.text,
                            email: emailController.text,
                          ));

                          fullNameController.clear();
                          emailController.clear();
                          passwordController.clear();
                          phoneNumberController.clear();
                        }

                        // -------- Sign Up Error State ---------
                        else if (state is ErrorAuthState) {
                          snackBarMassage(
                              context: context, errorText: state.message);
                        }
                      },

                      //------------------ listener widget ---------------------
                      child: ContainerWidget(
                        containerHeight: 48,
                        containerWidth: context.getWidth(),
                        containerColor: emailController.text.isNotEmpty ||
                                passwordController.text.isNotEmpty ||
                                fullNameController.text.isNotEmpty ||
                                phoneNumberController.text.isNotEmpty
                            ? green
                            : grey,
                        contanierBorderRadius: 10,

                        // ------------- on press 'إنشاء حساب' event -----------
                        onPressed: () {
                          // ------ 1) check if all field is empty or not ------
                          if (fullNameController.text.isEmpty ||
                              emailController.text.isEmpty ||
                              passwordController.text.isEmpty ||
                              phoneNumberController.text.isEmpty) {
                            snackBarMassage(
                                context: context,
                                errorText: 'رجاءََ قم بتعبئة جميع الخانات');
                          }

                          // ------ 2) check if validate is all good ------
                          // ---------  send the event to Auth Bloc  -------
                          if (_formField.currentState!.validate()) {
                            context.read<AuthBloc>().add(SignUpUserEvent(
                                fullName: fullNameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phoneNumber: phoneNumberController.text));
                          }
                        },
                        child: Center(
                          child: TextWidget(
                            text: 'إنشاء حساب',
                            textSize: 20,
                            textColor: emailController.text.isNotEmpty ||
                                    passwordController.text.isNotEmpty ||
                                    fullNameController.text.isNotEmpty ||
                                    phoneNumberController.text.isNotEmpty
                                ? white
                                : black,
                          ),
                        ),
                      ),
                    ),
                    height10,

                    //--------------------- Have Account -----------------------

                    LoginOrSignupWidget(
                      askText: 'لديك حساب ؟',
                      textButtom: 'تسجيل دخول',
                      navigatorTo: () {
                        context.pushScreen(screen: LoginView());
                      },
                    ),
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
