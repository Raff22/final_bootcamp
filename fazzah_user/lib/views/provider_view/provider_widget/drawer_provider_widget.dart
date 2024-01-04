import 'package:fazzah_user/utils/imports.dart';

class DrawerProviderWidget extends StatelessWidget {
  const DrawerProviderWidget({super.key, this.providerModel});
  final ProviderModel? providerModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: context.getHeight(divide: 8),
          bottom: context.getHeight(divide: 45)),
      child: SizedBox(
        child: Drawer(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(70),
              bottomLeft: Radius.circular(70),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    // --------------- Image and Name Provider ------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: ContainerWidget(
                            contanierBorderRadius: 0,
                            containerHeight: context.getWidth(divide: 4.5),
                            containerWidth: context.getWidth(divide: 4.5),
                            child: providerModel!.providerImage == null ||
                                    providerModel!.providerImage!.isEmpty
                                ? Image.asset(
                                    'assets/images/image_provider.png',
                                    fit: BoxFit.fill,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: providerModel!.providerImage!,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                        width20,
                        SizedBox(
                          width: context.getWidth(divide: 2.95),
                          child: TextWidget(
                            text: providerModel!.name!,
                            textSize: 20,
                          ),
                        )
                      ],
                    ),
                    height40,

                    //------------------- Provider Account ---------------------
                    SubProviderDrawerWidget(
                      subTextView: 'حسابي',
                      iconString: 'assets/images/account.png',
                      onPressed: () {
                        context.pushScreen(
                            screen: ProviderAccountView(
                          providerModel: providerModel,
                        ));
                      },
                    ),
                    height40,

                    //------------------- Provider Booking ---------------------
                    SubProviderDrawerWidget(
                      subTextView: 'الطلبات',
                      iconString: 'assets/images/shopping_cart.png',
                      onPressed: () {
                        context.pushScreen(
                            screen: ProviderBookingRequestsView(
                          providerModel: providerModel,
                        ));
                      },
                    ),
                    height40,

                    //------------------- Provider Rating ---------------------
                    SubProviderDrawerWidget(
                      subTextView: 'اراء العملاء',
                      iconString: 'assets/images/star.png',
                      onPressed: () {
                        context.read<BookingBloc>().add(
                            RequestProviderRatingsEvent(
                                providerId: providerModel!.id!));
                        context.pushScreen(
                            screen: ProviderRatingView(
                          providerModel: providerModel,
                        ));
                      },
                    ),
                    height40,

                    //------------------- Provider Wallet ---------------------
                    SubProviderDrawerWidget(
                      subTextView: 'المحفظة',
                      iconString: 'assets/images/wallet.png',
                      onPressed: () {
                        context.pushScreen(
                            screen: ProviderWalletView(
                          providerModel: providerModel,
                        ));
                        context.read<WalletBloc>().add(
                            RequestallWalletFirstEvent(id: providerModel!.id!));
                      },
                    ),
                    height40,

                    //--------------- Provider Working Time -------------------
                    SubProviderDrawerWidget(
                      subTextView: 'اوقات العمل',
                      iconString: 'assets/images/work_time.png',
                      onPressed: () {
                        context.read<ProviderBloc>().add(
                            GetProviderWorkingHoursEvent(
                                providerID: providerModel!.id!));
                        context.pushScreen(
                            screen: ProviderWorkTimePage(
                          providerModel: providerModel,
                        ));
                      },
                    ),
                    height40,
                  ],
                ),

                // --------------- Signout ------------------
                BlocListener<AuthBloc, AuthStatee>(
                  listener: (context, state) {
                    if (state is SignOutSuccessedState) {
                      context.removeUnitl(screen: LoginView());
                    }
                  },
                  child: ContainerWidget(
                    contanierBorderRadius: 0,
                    onPressed: () {
                      context.read<AuthBloc>().add(SignOutEvent());
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: red,
                        ),
                        width14,
                        TextWidget(
                          text: 'تسجيل خروج',
                          textColor: red,
                          textSize: 18,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
