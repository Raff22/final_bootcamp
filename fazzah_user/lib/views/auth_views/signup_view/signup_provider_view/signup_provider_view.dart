// ignore_for_file: must_be_immutable
import 'package:fazzah_user/bloc/visible_password_cubit/visible_password_cubit.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/container_widget.dart';
import 'package:fazzah_user/global/global_widget/text_form_field_widget.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/format_checkers/format_checks.dart';
import 'package:fazzah_user/utils/helpers/snackbar_mess.dart';
import 'package:fazzah_user/views/auth_views/auth_widget/logo_widget.dart';
import 'package:fazzah_user/views/auth_views/auth_widget/title_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupProviderView extends StatelessWidget {
  SignupProviderView({super.key});

  final _formField = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nationaltyController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController certificateController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();

  final TextEditingController yearsOfExperienceController =
      TextEditingController();
  final TextEditingController priceRangeController = TextEditingController();

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
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
              child: Form(
                key: _formField,
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

                    // ----------------- Text Field Pnone Number ----------------------

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

                    //--------------- Text Field Nationalty --------------------

                    TextFormFieldWidget(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'رجاءََ أدخل جنسيتك';
                        }
                        return null;
                      },
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      cursorColor: grey,
                      controller: nationaltyController,
                      labelText: 'الجنسية',
                      labelTextColor: grey,
                      controllerTextColor: dark1Green,
                      suffixIcon: const Icon(
                        Icons.language_rounded,
                        color: grey,
                      ),
                    ),
                    height20,

                    //-------------- Text Field Nationalty ID ------------------

                    TextFormFieldWidget(
                      validator: (value) {
                        bool nationalIdValid =
                            FormatCheck().checkNationalId(value!);
                        if (value.isEmpty) {
                          return 'رجاءََ أدخل الهوية الوطنية أو رقم الإقامة';
                        } else if (!nationalIdValid) {
                          return 'يجب ان يكون الهوية الوطنية أو رقم الإقامة عشر أرقام';
                        }
                        return null;
                      },
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      cursorColor: grey,
                      controller: nationalIdController,
                      labelText: 'الهوية الوطنية أو رقم الإقامة',
                      labelTextColor: grey,
                      controllerTextColor: dark1Green,
                      suffixIcon: Image.asset('assets/images/national_id.png'),
                    ),
                    height20,

                    //--------------- Text Field Age --------------------

                    TextFormFieldWidget(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'رجاءََ أدخل عمرك';
                        }
                        return null;
                      },
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      cursorColor: grey,
                      controller: ageController,
                      labelText: 'العمر',
                      labelTextColor: grey,
                      controllerTextColor: dark1Green,
                      suffixIcon: const Icon(
                        Icons.person,
                        color: grey,
                      ),
                    ),
                    height20,

                    //--------------- Text Field Certificate --------------------

                    TextFormFieldWidget(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'رجاءََ أدخل اسم شهادتك المهنية';
                        }
                        return null;
                      },
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      cursorColor: grey,
                      controller: certificateController,
                      labelText: 'اسم شهادة المهنية',
                      labelTextColor: grey,
                      controllerTextColor: dark1Green,
                      suffixIcon: const Icon(
                        Icons.workspace_premium_outlined,
                        color: grey,
                      ),
                    ),
                    height20,

                    //---------------- Text Field occupation -------------------

                    TextFormFieldWidget(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'رجاءََ أدخل مهنتك';
                        }
                        return null;
                      },
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      cursorColor: grey,
                      controller: occupationController,
                      labelText: 'المهنة',
                      hintText: 'سباكة , دهان , ... الخ',
                      labelTextColor: grey,
                      controllerTextColor: dark1Green,
                      suffixIcon: const Icon(
                        Icons.work_outline_outlined,
                        color: grey,
                      ),
                    ),
                    height20,

                    //----------------- Years Of Experience --------------------

                    TextFormFieldWidget(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'رجاءََ أدخل سنوات الخبرة';
                        }
                        return null;
                      },
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      cursorColor: grey,
                      controller: yearsOfExperienceController,
                      labelText: 'سنوات الخبرة',
                      labelTextColor: grey,
                      controllerTextColor: dark1Green,
                      suffixIcon: const Icon(
                        Icons.work_outline_outlined,
                        color: grey,
                      ),
                    ),
                    height20,

                    //----------------- Years Of Experience --------------------

                    TextFormFieldWidget(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'رجاءََ أدخل نطاق السعر المناسب لك';
                        }
                        return null;
                      },
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      cursorColor: grey,
                      controller: priceRangeController,
                      labelText: ' نطاق السعر بالريال السعودي',
                      hintText: '100-150 SR',
                      labelTextColor: grey,
                      controllerTextColor: dark1Green,
                      suffixIcon: const Icon(
                        Icons.monetization_on_outlined,
                        color: grey,
                      ),
                    ),
                    height20,

                    //------------ Container (إنشاء حساب) -------------------

                    ContainerWidget(
                      containerHeight: 48,
                      containerWidth: context.getWidth(),
                      containerColor: fullNameController.text.isNotEmpty ||
                              nationalIdController.text.isNotEmpty ||
                              phoneNumberController.text.isNotEmpty ||
                              emailController.text.isNotEmpty ||
                              passwordController.text.isNotEmpty ||
                              nationaltyController.text.isNotEmpty ||
                              ageController.text.isNotEmpty ||
                              certificateController.text.isNotEmpty ||
                              occupationController.text.isNotEmpty ||
                              yearsOfExperienceController.text.isNotEmpty ||
                              priceRangeController.text.isNotEmpty
                          ? green
                          : grey,
                      contanierBorderRadius: 10,
                      onPressed: () {
                        if (fullNameController.text.isNotEmpty ||
                            nationalIdController.text.isNotEmpty ||
                            phoneNumberController.text.isNotEmpty ||
                            emailController.text.isNotEmpty ||
                            passwordController.text.isNotEmpty ||
                            nationaltyController.text.isNotEmpty ||
                            ageController.text.isNotEmpty ||
                            certificateController.text.isNotEmpty ||
                            occupationController.text.isNotEmpty ||
                            yearsOfExperienceController.text.isNotEmpty ||
                            priceRangeController.text.isNotEmpty) {
                          snackBarMassage(
                              context: context,
                              snackBarText: 'رجاءََ قم بتعبئة جميع الخانات');
                        }
                      },
                      child: Center(
                        child: TextWidget(
                          text: 'إنشاء حساب',
                          textSize: 20,
                          textColor: fullNameController.text.isNotEmpty ||
                                  nationalIdController.text.isNotEmpty ||
                                  phoneNumberController.text.isNotEmpty ||
                                  emailController.text.isNotEmpty ||
                                  passwordController.text.isNotEmpty ||
                                  nationaltyController.text.isNotEmpty ||
                                  ageController.text.isNotEmpty ||
                                  certificateController.text.isNotEmpty ||
                                  occupationController.text.isNotEmpty ||
                                  yearsOfExperienceController.text.isNotEmpty ||
                                  priceRangeController.text.isNotEmpty
                              ? white
                              : black,
                        ),
                      ),
                    )
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
