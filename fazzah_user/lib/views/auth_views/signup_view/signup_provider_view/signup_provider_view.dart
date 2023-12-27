// ignore_for_file: must_be_immutable
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

class SignupProviderView extends StatelessWidget {
  SignupProviderView({super.key, required this.isProvider});

  final bool isProvider;
  final _formFieldProvider = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController nationalIdController = TextEditingController();

  final TextEditingController nationaltyController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final TextEditingController certificateController = TextEditingController();

  final TextEditingController jobController = TextEditingController();

  final TextEditingController servicesController = TextEditingController();

  final TextEditingController yearsOfExperienceController =
      TextEditingController();

  final TextEditingController priceRangeController = TextEditingController();

  // it will be true and comes from login
  @override
  Widget build(BuildContext context) {
    //print('is provider ${isProvider}');
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
                key: _formFieldProvider,
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

                    //---------------- Text Field Job -------------------

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
                      controller: jobController,
                      labelText: 'المهنة',
                      labelTextColor: grey,
                      controllerTextColor: dark1Green,
                      suffixIcon: const Icon(
                        Icons.work_outline_outlined,
                        color: grey,
                      ),
                    ),
                    height20,

                    //---------------- Text Field services -------------------

                    TextFormFieldWidget(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'رجاءََ أدخل خدماتك';
                        }
                        return null;
                      },
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      cursorColor: grey,
                      controller: servicesController,
                      labelText: 'الخدمات',
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

                    BlocListener<AuthBloc, AuthStatee>(
                      listener: (context, state) {
                        // ------------- Loading State --------------
                        if (state is LoadingAuthSignupState) {
                          showLoadingDialog(context: context);
                        }

                        // -------- Sign Up Successed State ---------
                        else if (state is SignUpSuccessedProviderState) {
                          context.removeUnitl(
                              screen: OtpView(
                            email: emailController.text,
                            isProvider: isProvider,
                          ));

                          fullNameController.clear();
                          nationalIdController.clear();
                          phoneNumberController.clear();
                          emailController.clear();
                          passwordController.clear();
                          nationaltyController.clear();
                          ageController.clear();
                          certificateController.clear();
                          servicesController.clear();
                          yearsOfExperienceController.clear();
                          priceRangeController.clear();
                        }

                        // -------- Sign Up Error State ---------
                        else if (state is ErrorAuthSignupState) {
                          context.popScreen();
                          snackBarMassage(
                              context: context, snackBarText: state.message);
                        }
                      },
                      child: ContainerWidget(
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
                                servicesController.text.isNotEmpty ||
                                yearsOfExperienceController.text.isNotEmpty ||
                                priceRangeController.text.isNotEmpty
                            ? green
                            : grey,
                        contanierBorderRadius: 10,

                        // ------------- on press 'إنشاء حساب' event -----------
                        onPressed: () {
                          // ------ 1) check if all field is empty or not ------
                          if (fullNameController.text.isEmpty ||
                              nationalIdController.text.isEmpty ||
                              phoneNumberController.text.isEmpty ||
                              emailController.text.isEmpty ||
                              passwordController.text.isEmpty ||
                              nationaltyController.text.isEmpty ||
                              ageController.text.isEmpty ||
                              certificateController.text.isEmpty ||
                              servicesController.text.isEmpty ||
                              yearsOfExperienceController.text.isEmpty ||
                              priceRangeController.text.isEmpty ||
                              servicesController.text.isEmpty) {
                            snackBarMassage(
                                context: context,
                                snackBarText: 'رجاءََ قم بتعبئة جميع الخانات');
                          }
                          // ------ 2) check if validate is all good ------
                          // ------- and send the event with data to Auth Bloc -------
                          else if (_formFieldProvider.currentState!
                              .validate()) {
                            context.read<AuthBloc>().add(SignUpProviderEvent(
                                fullName: fullNameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phoneNumber: phoneNumberController.text,
                                nationalty: nationaltyController.text,
                                nationalId: nationalIdController.text,
                                age: ageController.text,
                                certificate: certificateController.text,
                                job: jobController.text,
                                services: servicesController.text,
                                yearsOfExperience:
                                    yearsOfExperienceController.text,
                                priceRange: priceRangeController.text));
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
                                    servicesController.text.isNotEmpty ||
                                    yearsOfExperienceController
                                        .text.isNotEmpty ||
                                    priceRangeController.text.isNotEmpty
                                ? white
                                : black,
                          ),
                        ),
                      ),
                    ),
                    height20,
                    //--------------------- Have Account -----------------------

                    RowTowTextWidget(
                      mainAxisAlignment: MainAxisAlignment.center,
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
