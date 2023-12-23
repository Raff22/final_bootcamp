// ignore_for_file: must_be_immutable

import 'package:fazzah_user/bloc/visible_password_cubit/visible_password_cubit.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/text_form_field_widget.dart';
import 'package:fazzah_user/utils/format_checkers/format_checks.dart';
import 'package:fazzah_user/views/auth_views/auth_widget/logo_widget.dart';
import 'package:fazzah_user/views/auth_views/auth_widget/title_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class SignupProviderView extends StatelessWidget {
  SignupProviderView({super.key});

  // final _formField = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  MultiSelectController<String>? occupationController;
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
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

                    // ----------------- Text Field Full Name ------------------

                    TextFormFieldWidget(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'رجاءََ أدخل اسمك الثلاثي';
                        }
                        return '';
                      },
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      cursorColor: grey,
                      controller: fullNameController,
                      labelText: 'الإسم الثلاثي',
                      labelTextColor: grey,
                      controllerTextColor: dark1Green,
                      prefixIcon: const Icon(
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

                    // ----------------- Text Field Pnone Number ----------------------

                    TextFormFieldWidget(
                      validator: (value) {
                        bool phoneValid = FormatCheck().checkPhone(value!);
                        if (value.isEmpty) {
                          return 'رجاءََ أدخل رقم الهاتف';
                        } else if (!phoneValid) {
                          return '05xxxxxxxxx يجب ان يكون رقم الهاتف عشر أرقام ويبدا ب';
                        }
                        return '';
                      },
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                      cursorColor: grey,
                      controller: phoneNumberController,
                      labelText: 'رقم الهاتف',
                      labelTextColor: grey,
                      controllerTextColor: dark1Green,
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: grey,
                      ),
                    ),
                    height20,

                    //--------------- Text Field Nationalty --------------------
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
                        return '';
                      },
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                      cursorColor: grey,
                      controller: nationalIdController,
                      labelText: 'الهوية الوطنية أو رقم الإقامة',
                      labelTextColor: grey,
                      controllerTextColor: dark1Green,
                      prefixIcon: Image.asset('assets/images/national_id.png'),
                    ),
                    height20,

                    //---------------- Text Field occupation -------------------
                    // MultiSelectDropDown(
                    //   suffixIcon: const Icon(
                    //     Icons.card_travel,
                    //     color: grey,
                    //   ),
                    //   borderColor: grey,
                    //   borderRadius: 10,
                    //   borderWidth: 0.95,
                    //   backgroundColor: noColor,
                    //   hintFontSize: 20,
                    //   hintColor: grey,
                    //   hint: 'المهنة',
                    //   dropdownBorderRadius: 10,
                    //   showClearIcon: true,
                    //   controller: occupationController,
                    //   onOptionSelected: (options) {
                    //     debugPrint(options.toString());
                    //     print(options);
                    //   },
                    //   options: const <ValueItem>[
                    //     ValueItem(label: 'سباك', value: 'سباك'),
                    //     ValueItem(label: 'دهان', value: 'دهان'),
                    //     ValueItem(label: 'كهربائي', value: 'كهربائي'),
                    //     ValueItem(label: 'تركيب', value: 'تركيب'),
                    //   ],
                    //   maxItems: 4,
                    //   disabledOptions: const [
                    //     ValueItem(label: 'Option 1', value: '1')
                    //   ],
                    //   selectionType: SelectionType.multi,
                    //   chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                    //   optionTextStyle:
                    //       const TextStyle(fontSize: 17, color: dark1Green),
                    //   selectedOptionIcon: const Icon(
                    //     Icons.check_circle,
                    //     color: green,
                    //   ),
                    // ),
                    height20,

                    //----------------- Years Of Experience --------------------
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
