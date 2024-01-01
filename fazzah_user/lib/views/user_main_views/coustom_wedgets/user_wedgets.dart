import 'package:cached_network_image/cached_network_image.dart';
import 'package:fazzah_user/bloc/booking/booking_bloc.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/models/order_model.dart';
import 'package:fazzah_user/models/payment_method.dart';
import 'package:fazzah_user/models/order_model.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/views/booking_views/provider_view_screen.dart';
import 'package:fazzah_user/views/booking_views/providers_view.dart';
import 'package:fazzah_user/views/user_main_views/blocks/fav_bloc/fav_bloc.dart';
import 'package:fazzah_user/views/user_main_views/blocks/fav_bloc/fav_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkerCard extends StatelessWidget {
  const WorkerCard({
    super.key,
    required this.providerInfo,
    required this.isFav,
  });
  final ProviderModel providerInfo;
  final bool isFav;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushScreen(
            screen:
                ProviderViewScreen(isFav: isFav, providerInfo: providerInfo));
      },
      child: Container(
          height: context.getHeight(divide: 7),
          width: context.getWidth(divide: 1.1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xffeff0eb),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: (providerInfo.providerImage == null ||
                          providerInfo.providerImage!.isEmpty)
                      ? Image.asset('assets/images/Logo_provider.png',
                          width: 96, height: 96, fit: BoxFit.fill)
                      : CachedNetworkImage(
                          width: 96,
                          height: 96,
                          imageUrl: providerInfo.providerImage!,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(color: green),
                          fit: BoxFit.fill),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(providerInfo.name ?? "",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("السعر التقريبي ${providerInfo.priceRange ?? ""} رس"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.green[300]),
                        Text("${providerInfo.rateAverage ?? ""} "),
                        Text(
                          "(تقييم ${providerInfo.ratesNumber ?? ""})",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[500]),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.grey[500]),
                        Text(
                          "7 كم",
                          style: TextStyle(color: Colors.grey[500]),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class WorkerCardorder extends StatelessWidget {
  bool isFav = false;
  WorkerCardorder({
    super.key,
    required this.providerInfo,
    required this.order,
  });
  final ProviderModel providerInfo;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushScreen(
            screen:
                ProviderViewScreen(isFav: isFav, providerInfo: providerInfo));
      },
      child: Container(
          height: context.getHeight(divide: 7),
          width: context.getWidth(divide: 1.1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xffeff0eb),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: (providerInfo.providerImage == null ||
                          providerInfo.providerImage!.isEmpty)
                      ? Image.asset('assets/images/Logo_provider.png',
                          width: 96, height: 96, fit: BoxFit.fill)
                      : CachedNetworkImage(
                          width: 96,
                          height: 96,
                          imageUrl: providerInfo.providerImage!,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(color: green),
                          fit: BoxFit.fill),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(providerInfo.name ?? "",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("السعر التقريبي ${providerInfo.priceRange ?? ""} رس"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.green[300]),
                        Text("${providerInfo.rateAverage ?? ""} "),
                        Text(
                          "(تقييم ${providerInfo.ratesNumber ?? ""})",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[500]),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.grey[500]),
                        Text(
                          "7 كم",
                          style: TextStyle(color: Colors.grey[500]),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class kdmatWedget extends StatelessWidget {
  const kdmatWedget({
    super.key,
    required this.img,
    required this.text,
  });
  final String img;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context
            .read<BookingBloc>()
            .add(RequestProvidersByServiceEvent(service: text));
        context.pushScreen(screen: const ProvidersScreen());
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: context.getHeight(divide: 5.4),
          width: context.getWidth(divide: 2.5),
          color: const Color(0xffeff0eb),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(img)),
              ),
              Text(
                text,
                style:
                    const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class mainScreenAppbar extends StatelessWidget {
  const mainScreenAppbar({
    super.key,
    required this.title,
    this.iconrisht,
    this.iconleft,
  });
  final String title;
  final IconData? iconrisht;
  final IconData? iconleft;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: context.getHeight(divide: 7),
        width: context.getWidth(divide: 1),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          color: Color(0xffeff0eb),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(iconrisht),
              Text(
                title,
                style: const TextStyle(fontSize: 29),
              ),
              Icon(iconleft)
            ],
          ),
        ));
  }
}

class HomeScreenBotton extends StatelessWidget {
  const HomeScreenBotton({
    super.key,
    required this.text,
    required this.color,
    required this.textcolor,
  });
  final String text;
  final Color color;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(divide: 1.2),
      height: context.getHeight(divide: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 20, color: textcolor),
        ),
      ),
    );
  }
}
