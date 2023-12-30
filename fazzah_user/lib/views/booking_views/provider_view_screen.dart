import 'package:cached_network_image/cached_network_image.dart';
import 'package:fazzah_user/bloc/booking/booking_bloc.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/container_widget.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/rating_model.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/views/booking_views/booking_details_view.dart';
import 'package:fazzah_user/views/booking_views/booking_widgets/provider_view_widgets.dart';
import 'package:fazzah_user/views/user_main_views/blocks/fav_bloc/fav_bloc.dart';
import 'package:fazzah_user/views/user_main_views/blocks/fav_bloc/fav_event.dart';
import 'package:fazzah_user/views/user_main_views/blocks/fav_bloc/fav_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProviderViewScreen extends StatefulWidget {
  ProviderViewScreen(
      {super.key, required this.providerInfo, required this.isFav});
  final ProviderModel providerInfo;
  bool isFav;

  @override
  State<ProviderViewScreen> createState() => _ProviderViewScreenState();
}

class _ProviderViewScreenState extends State<ProviderViewScreen>
    with TickerProviderStateMixin {
  List<String> services = [];
  List<Rating> ratings = [];

  @override
  void initState() {
    if (widget.providerInfo.services != null) {
      services = widget.providerInfo.services!.split('،');
    }
    context
        .read<BookingBloc>()
        .add(RequestProviderRatingsEvent(providerId: widget.providerInfo.id!));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabsController = TabController(length: 3, vsync: this);
    return Scaffold(
        appBar: createAppBar(
            trailing: IconButton(onPressed: () {
              context.read<FavBloc>().add(FavToggleEvent(
                  state: widget.isFav, providerID: widget.providerInfo.id!));
            }, icon: BlocBuilder<FavBloc, FavState>(
              builder: (context, state) {
                if (state is FavSelected) {
                  if (state.id == widget.providerInfo.id!) {
                    widget.isFav = state.isFav;
                  }
                }
                return Icon(
                  widget.isFav ? Icons.favorite : Icons.favorite_border,
                  size: 30,
                  color: Colors.red,
                );
              },
            )),
            title: "الفني",
            context: context,
            leading: IconButton(
                onPressed: () {
                  context.read<BookingBloc>().add(RequestProvidersEvent());
                  context.popScreen();
                },
                icon:
                    const Icon(Icons.arrow_back_ios, size: 20, color: black))),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                height20,
                ClipOval(
                  child: (widget.providerInfo.providerImage == null ||
                          widget.providerInfo.providerImage!.isEmpty)
                      ? Image.asset(
                          'assets/images/Logo_provider.png',
                          height: 150,
                          width: 150,
                        )
                      : CachedNetworkImage(
                          imageUrl: widget.providerInfo.providerImage!,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(color: green),
                          height: 150,
                          width: 150,
                        ),
                ),
                TextWidget(text: "${widget.providerInfo.name}", textSize: 34),
                TextWidget(
                    text:
                        "السعر التقريبي ${widget.providerInfo.priceRange ?? "100"} رس",
                    textSize: 20),
                SizedBox(
                  width: context.getWidth(divide: 1.02),
                  height: 70,
                  child: TabBar(
                      indicatorColor: green,
                      labelStyle: const TextStyle(
                          fontSize: 20, fontFamily: "SF-Arabic"),
                      labelColor: green,
                      dividerColor: grey,
                      controller: tabsController,
                      tabs: const [
                        Tab(text: "المعلومات"),
                        Tab(text: "الخدمات"),
                        Tab(text: "آراء العملاء"),
                      ]),
                ),
                SizedBox(
                  width: context.getWidth(divide: 1.02),
                  height: context.getHeight(divide: 3),
                  child: TabBarView(
                    controller: tabsController,
                    children: [
                      ProviderInfoWidget(provider: widget.providerInfo),
                      ProviderServicesTabView(services: services),
                      BlocBuilder<BookingBloc, BookingState>(
                        builder: (context, state) {
                          if (state is ShowProviderRatingsState) {
                            return ListView.separated(
                              itemCount: state.ratings.length,
                              itemBuilder: (context, index) => MyRatingWidget(
                                  ratingInfo: state.ratings[index]),
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Divider();
                              },
                            );
                          } else if (state is BookingLoadingState) {
                            return const Center(
                                child: CircularProgressIndicator(color: green));
                          } else if (state is BookingErrorState) {
                            return Center(child: Text(state.error));
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                ContainerWidget(
                    contanierBorderRadius: 10,
                    containerWidth: context.getWidth(),
                    containerHeight: 48,
                    containerColor: green,
                    onPressed: () {
                      context.read<BookingBloc>().add(GetProviderHoursEvent(
                          providerId: widget.providerInfo.id!));
                      context.pushScreen(
                          screen: BookingDetailsView(
                        providerInfo: widget.providerInfo,
                      ));
                    },
                    child: const Center(
                        child: TextWidget(
                      text: "احجز الآن",
                      textSize: 25,
                      textColor: lightGrey,
                    ))),
              ],
            ),
          ),
        ));
  }
}
