// ignore_for_file: must_be_immutable
import 'package:fazzah_user/utils/imports.dart';

class OtpView extends StatelessWidget {
  OtpView({
    super.key,
    required this.email,
    required this.isProvider,
  });
  final String email;
  final bool isProvider; // it will be true if is provider and false if is user

  final _formField = GlobalKey<FormState>();

  TextEditingController pin1 = TextEditingController();

  TextEditingController pin2 = TextEditingController();

  TextEditingController pin3 = TextEditingController();

  TextEditingController pin4 = TextEditingController();

  TextEditingController pin5 = TextEditingController();

  TextEditingController pin6 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              context.pushScreen(screen: LoginView());
            },
          ),
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
                      supTitle: 'تم إرسال رمز التحقق إلى $email',
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
                    TimerButton(
                      color: coldGreen,
                      activeTextStyle: const TextStyle(color: black),
                      label: " اعادة ارسال رمز تحقق",
                      timeOutInSeconds: 70,
                      onPressed: () {
                        context.read<AuthBloc>().add(ResendOTPEvent(
                              email: email,
                            ));
                        snackBarMassage(
                            context: context,
                            snackBarText:
                                'تم ارسال رمز التحقق  مرة أخرى الى البريد الإلكتروني $email');
                      },
                    ),
                    height20,

                    // --------------  Container (تسجيل دخول)  ---------------

                    BlocListener<AuthBloc, AuthStatee>(
                      //--------------- listener function ----------------------
                      listener: (context, state) async {
                        // ------------- Loading State --------------
                        if (state is LoadingAuthOTPState) {
                          showLoadingDialog(context: context);
                        }

                        // ------------ OTP Successed State -----------
                        else if (state is OTPSuccessedUserState) {
                          if (pin1.text.isEmpty ||
                              pin2.text.isEmpty ||
                              pin3.text.isEmpty ||
                              pin4.text.isEmpty ||
                              pin5.text.isEmpty ||
                              pin6.text.isEmpty) {
                            snackBarMassage(
                                context: context,
                                snackBarText: 'من فضلك قم بكتابة الرمز');
                          } else {
                            context.removeUnitl(
                                screen: NavBar(user: state.currentUser!));
                            pin1.clear();
                            pin2.clear();
                            pin3.clear();
                            pin4.clear();
                            pin5.clear();
                            pin6.clear();
                          }
                        } else if (state is OTPSuccessedProviderState) {
                          if (pin1.text.isEmpty ||
                              pin2.text.isEmpty ||
                              pin3.text.isEmpty ||
                              pin4.text.isEmpty ||
                              pin5.text.isEmpty ||
                              pin6.text.isEmpty) {
                            snackBarMassage(
                                context: context,
                                snackBarText: 'من فضلك قم بكتابة الرمز');
                          } else {
                            context.removeUnitl(
                                screen: ProviderBookingRequestsView(
                              providerModel: state.currentprovider,
                            ));
                            pin1.clear();
                            pin2.clear();
                            pin3.clear();
                            pin4.clear();
                            pin5.clear();
                            pin6.clear();
                          }
                        }

                        // -------- OTP Error State ---------
                        else if (state is ErrorAuthOTPState) {
                          context.popScreen();
                          snackBarMassage(
                              context: context,
                              snackBarText:
                                  'رمز التحقق غير صحيح أو منتهي صلاحيتة');
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
                                email: email,
                                isProvider: isProvider));
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
}
