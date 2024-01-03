// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:async';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/container_widget.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/models/address.dart';
import 'package:fazzah_user/models/user_model.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/utils/helpers/snackbar_mess.dart';
import 'package:fazzah_user/views/chat_views/chat_widgets/provider_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class TrackingView extends StatefulWidget {
  const TrackingView({
    super.key,
    required this.user,
    required this.address,
  });
  final UserModel user;
  final Address address;

  @override
  State<TrackingView> createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> {
  late double latitude;
  late double longitude;
  late LatLng userDestination;
  @override
  void initState() {
    latitude = widget.address.latitude!;
    longitude = widget.address.longitude!;
    userDestination = LatLng(latitude, longitude);
    super.initState();
  }

  //----------------------------------------------------------------------------
  final Completer<GoogleMapController> _controller = Completer();

  //----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0ede5),
      appBar: createAppBar(
        title: "تتبع الحجز",
        centerTitle: true,
        context: context,
        leading: IconButton(
          onPressed: () {
            context.popScreen();
          },
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: black),
        ),
      ),
      //----------------------------
      body: SizedBox(
        height: context.getHeight(divide: 1.60),
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition:
              CameraPosition(target: userDestination, zoom: 13),
          markers: {
            Marker(
                markerId: const MarkerId('User Location'),
                position: userDestination),
          },
          onMapCreated: (GoogleMapController controllerMap) {
            _controller.complete(controllerMap);
          },
        ),
      ),

      //----------------------------
      bottomSheet: Container(
        height: context.getHeight(divide: 4),
        width: context.getWidth(),
        decoration: const BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ContainerWidget(
                  containerHeight: context.getWidth(divide: 95),
                  containerWidth: context.getWidth(divide: 5),
                  containerColor: grey,
                  contanierBorderRadius: 50),
              height6,
              ListTile(
                title: TextWidget(
                  text: widget.user.name!,
                  textSize: 22,
                ),
                subtitle: const Text("الوقت المتوقع للوصول : ٣ دقائق"),
                trailing: Wrap(
                  spacing: 10,
                  children: [
                    // -------- Call user -----------
                    SmallSquareForContactAndMessage(
                        icon: Icons.phone, onpressed: () {}),

                    // -------- Meassage user -----------
                    SmallSquareForContactAndMessage(
                        icon: Icons.message,
                        onpressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProviderchatScreen(
                                        provider: widget.user,
                                      )));
                        }),
                  ],
                ),
              ),
              height10,
              ContainerWidget(
                containerHeight: 48,
                containerWidth: context.getWidth(),
                contanierBorderRadius: 10,
                containerColor: green,
                onPressed: () {
                  MapUtils.openMap(
                      context: context,
                      latitude: latitude,
                      longitude: longitude);
                },
                child: const Center(
                    child: TextWidget(
                  text: 'فتح قوقل ماب لتتبع الموقع',
                  textColor: white,
                  textSize: 18,
                )),
              ),
              height30
            ],
          ),
        ),
      ),
    );
  }
}

class SmallSquareForContactAndMessage extends StatelessWidget {
  const SmallSquareForContactAndMessage({
    super.key,
    required this.icon,
    required this.onpressed,
  });
  final IconData icon;
  final Function() onpressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: lightGreen,
        child: IconButton(
            color: green, onPressed: onpressed, icon: Icon(icon, size: 20)),
      ),
    );
  }
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(
      {required BuildContext context,
      required double latitude,
      required double longitude}) async {
    String googleMapUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    final uri = Uri.parse(googleMapUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw snackBarMassage(
          context: context, snackBarText: 'Could not open the Map');
    }
  }
}
