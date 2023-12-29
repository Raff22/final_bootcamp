import 'package:cached_network_image/cached_network_image.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/container_widget.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/views/provider_view/provider_account_view.dart';
import 'package:fazzah_user/views/provider_view/provider_booking_requests_view.dart';
import 'package:fazzah_user/views/provider_view/provider_rateing_view.dart';
import 'package:fazzah_user/views/provider_view/provider_wallet_view.dart';
import 'package:fazzah_user/views/provider_view/provider_widget/drawer_widget/sub_provider_drawer_widget.dart';
import 'package:fazzah_user/views/provider_view/provider_workin_time_page.dart';
import 'package:flutter/material.dart';

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
                            containerHeight: context.getWidth(divide: 4),
                            containerWidth: context.getWidth(divide: 4),
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
                      },
                    ),
                    height40,
                    
                     //--------------- Provider Working Time ------------------- 
                    SubProviderDrawerWidget(
                      subTextView: 'اوقات العمل',
                      iconString: 'assets/images/work_time.png',
                      onPressed: () {
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
                ContainerWidget(
                  contanierBorderRadius: 0,
                  onPressed: () {},
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
