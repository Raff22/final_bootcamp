import 'package:fazzah_user/utils/imports.dart';

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
                  if (stateUser == true) {
                    emailController.text = 'wiqykexu@pelagius.net';
                    passwordController.text = '1234567';
                  } else if (stateUser == false) {
                    emailController.text = 'bewepob849@ubinert.com';
                    passwordController.text = '123456';
                  }
                  // stateUser if is true is provider and if it false is user
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

                        // ----------------- Text Filed Password -------------------

                        BlocBuilder<VisiblePasswordCubit, bool>(
                          builder: (context, statePassword) {
                            return TextFormFieldWidget(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'رجاءََ أدخل الرقم السري';
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

                        // --------------  Container (تسجيل دخول)  ---------------

                        BlocListener<AuthBloc, AuthStatee>(
                          listener: (context, state) async {
                            if (state is LoadingAuthLoginState) {
                              showLoadingDialog(context: context);
                            } else if (state is LoginSuccessedUserState) {
                              context.removeUnitl(
                                  screen: NavBar(user: state.currentUser));

                              emailController.clear();
                              passwordController.clear();
                            } else if (state is LoginSuccessedProviderState) {
                              context.removeUnitl(
                                  screen: ProviderBookingRequestsView(
                                      providerModel: state.currentprovider));
                              emailController.clear();
                              passwordController.clear();
                            } else if (state is ErrorAuthLoginState) {
                              context.popScreen();
                              snackBarMassage(
                                  context: context,
                                  snackBarText:
                                      'البريد الإلكتروني او الرقم السري غير صحيح');
                            }
                          },
                          child: ContainerWidget(
                            containerHeight: 48,
                            containerWidth: context.getWidth(),
                            containerColor: emailController.text.isNotEmpty ||
                                    passwordController.text.isNotEmpty
                                ? green
                                : grey,
                            contanierBorderRadius: 10,
                            onPressed: () {
                              // ------ 1) check if all field is empty or not ------
                              if (emailController.text.isEmpty ||
                                  passwordController.text.isEmpty) {
                                snackBarMassage(
                                    context: context,
                                    snackBarText:
                                        'رجاءََ قم بتعبئة جميع الخانات');
                              }

                              // ------ 2) check if validate is all good ------
                              // ------- and send the event with data to Auth Bloc -------
                              else if (_formField.currentState!.validate()) {
                                print(stateUser);
                                context.read<AuthBloc>().add(LoginEvent(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    isProvider: stateUser));
                              }
                            },
                            child: Center(
                              child: TextWidget(
                                text: 'تسجيل دخول',
                                textSize: 20,
                                textColor: emailController.text.isNotEmpty ||
                                        passwordController.text.isNotEmpty
                                    ? white
                                    : black,
                              ),
                            ),
                          ),
                        ),
                        height10,

                        // --------------------  Row Text  ---------------------

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //------------------ Provider or User --------------

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

                            RowTowTextWidget(
                              mainAxisAlignment: MainAxisAlignment.center,
                              askText: 'لا تمتلك حساب ؟',
                              textButtom: 'إنشاء حساب',
                              navigatorTo: () {
                                stateUser
                                    ? context.pushScreen(
                                        screen: SignupProviderView(
                                        isProvider: stateUser,
                                      ))
                                    : context.pushScreen(
                                        screen: SignupUserView(
                                        isProvider: stateUser,
                                      ));
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
