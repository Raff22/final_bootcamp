// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fazzah_user/app_data/static_data.dart';
import 'package:fazzah_user/bloc/booking/booking_bloc.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/search_bar.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/models/address.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/user_model.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/helpers/name_formatter.dart';
import 'package:fazzah_user/views/booking_views/booking_widgets/rating_bottom_sheet.dart';
import 'package:fazzah_user/views/booking_views/providers_view.dart';
import 'package:fazzah_user/views/user_main_views/blocks/user_bloc.dart';
import 'package:fazzah_user/views/user_main_views/blocks/user_event.dart';
import 'package:fazzah_user/views/user_main_views/blocks/user_state.dart';
import 'package:fazzah_user/views/user_main_views/coustom_wedgets/user_wedgets.dart';
import 'package:fazzah_user/views/user_main_views/more_screens/add_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainView extends StatelessWidget {
  MainView(
      {super.key,
      required this.user,
      this.ratedprovider,
      this.showRating = false});
  final UserModel user;
  bool showRating;
  ProviderModel? ratedprovider;

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();

    return Scaffold(
        bottomSheet: showRating
            ? RatingBottomSheet(provider: ratedprovider!, user: user)
            : null,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 250, top: 50),
                child: Text(" أهلا ، ${getFirstWord(user.name!)}",
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),

              height10,

              //-------------------- Add user Location ------------------
              InkWell(
                onTap: () {
                  final Address address = Address(
                      city: 'Riyadh',
                      address: 'RFHA7596,Al Hamra,Riyadh Principality,13216',
                      latitude: 24.774265,
                      longitude: 46.738586);
                  context.pushScreen(
                    screen: AddPlaceScreen(
                      user: user,
                      address: address,
                    ),
                    then: (p0) {
                      if (p0 == "back") {
                        context.read<UserBloc>().add(GetLastUserAddressEvent());
                      }
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_pin,
                        color: grey,
                      ),
                      width10,
                      Wrap(direction: Axis.vertical, children: [
                        BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) {
                            if (state is LastAddressTitleState) {
                              print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                              print(state.addressTitle);
                              print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                              return TextWidget(
                                text: state.addressTitle,
                                textColor: darkGrey,
                              );
                            }
                            return const TextWidget(
                              text: 'انقر لإضافة عنوان جديد',
                              textColor: darkGrey,
                            );
                          },
                        ),
                      ])
                    ],
                  ),
                ),
              ),
              //------------------------------------------------------------
              height20,
              SearchBarWidget(
                  hint: "ابحث عن الخدمة",
                  onSubmmited: (String) {
                    context.read<BookingBloc>().add(
                        RequestProvidersByServiceEvent(
                            service: search.text.trim()));
                    context.pushScreen(screen: const ProvidersScreen());
                  },
                  controller: search),
              Container(
                  child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
                items: adslist
                    .map((item) => Container(
                          color: Colors.white,
                          child: Center(child: Image.asset(item.toString())),
                        ))
                    .toList(),
              )),
              const Padding(
                padding: EdgeInsets.only(left: 300),
                child: Text("خدماتنا",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      kdmatWedget(
                          img: "assets/images/imgg1.png", text: "سباكة"),
                      SizedBox(width: 10),
                      kdmatWedget(
                          img: "assets/images/electric.png", text: "كهرباء"),
                      SizedBox(width: 10),
                      kdmatWedget(
                          img: "assets/images/imgg1.png", text: "تركيب"),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                  left: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("اقرب الفنيين لك",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.black)),
                    InkWell(
                      onTap: () {
                        context
                            .read<BookingBloc>()
                            .add(RequestProvidersEvent());
                        context.pushScreen(screen: const ProvidersScreen());
                      },
                      child: const Text("عرض الكل",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Colors.black)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              WorkerCard(
                  providerInfo: ProviderModel(
                      name: " نور احمد",
                      rateAverage: 4.5,
                      ratesNumber: 100,
                      priceRange: "100-150",
                      providerImage:
                          'https://freepngimg.com/thumb/industrial_worker/168550-worker-png-file-hd.png'),
                  isFav: false),
            ],
          ),
        ));
  }
}
