import 'package:cached_network_image/cached_network_image.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/container_widget.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/views/booking_views/booking_details_view.dart';
import 'package:flutter/material.dart';

class ProviderViewScreen extends StatefulWidget {
  const ProviderViewScreen({super.key, required this.providerInfo});
  final ProviderModel providerInfo;

  @override
  State<ProviderViewScreen> createState() => _ProviderViewScreenState();
}

class _ProviderViewScreenState extends State<ProviderViewScreen>
    with TickerProviderStateMixin {
  //take provider model object

  @override
  Widget build(BuildContext context) {
    TabController tabsController = TabController(length: 3, vsync: this);
    return Scaffold(
        appBar: createAppBar(
            title: "الفني",
            context: context,
            leading: IconButton(
                onPressed: () {
                  context.popScreen();
                },
                icon:
                    const Icon(Icons.arrow_back_ios, size: 20, color: black))),
        body: SafeArea(
          child: Center(
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
                      textSize: 22),
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
                      children: const [
                        Center(
                          child: Text("المعلومات"),
                        ),
                        Center(
                          child: Text("الخدمات"),
                        ),
                        Center(
                          child: Text("آراء العملاء"),
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
                        context.pushScreen(screen: const BookingDetailsView());
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
          ),
        ));
  }
}
