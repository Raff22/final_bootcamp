// ignore_for_file: avoid_print
import 'dart:async';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/container_widget.dart';
import 'package:fazzah_user/global/global_widget/text_form_field_widget.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/models/address.dart';
import 'package:fazzah_user/models/user_model.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/utils/helpers/show_dialog_message.dart';
import 'package:fazzah_user/views/user_main_views/blocks/user_bloc.dart';
import 'package:fazzah_user/views/user_main_views/blocks/user_event.dart';
import 'package:fazzah_user/views/user_main_views/blocks/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key, required this.user, required this.address});
  final UserModel user;
  final Address address;

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  //----------------------------------------------------------------------------
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition googlePlex =
      CameraPosition(target: LatLng(24.774265, 46.738586), zoom: 13);
  //----------------------------------------------------------------------------
  final List<Marker> markers = <Marker>[
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(24.774265, 46.738586),
        infoWindow: InfoWindow(title: 'title marker'))
  ];
  //----------------------------------------------------------------------------
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print('error${error.toString()}');
    });

    return await Geolocator.getCurrentPosition();
  }

  //----------------------------------------------------------------------------
  String? cityName;
  String? address;
  late double latitude;
  late double longitude;
  TextEditingController addressTitle = TextEditingController();
  //---- initial values -----
  @override
  void initState() {
    cityName = widget.address.city;
    address = widget.address.address;
    latitude = widget.address.latitude!;
    longitude = widget.address.longitude!;
    addressTitle.text = widget.address.addressTitle ?? '';

    super.initState();
  }

  final _formNewAddressField = GlobalKey<FormState>();

  //-------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: googlBackgroundColor,
      appBar: createAppBar(
          context: context,
          title: 'تحديد الموقع',
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                context.popScreen();
                context.read<UserBloc>().add(GetAllUserAddressEvent());
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded))),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: googlePlex,
        markers: Set<Marker>.of(markers),
        onMapCreated: (GoogleMapController controllerMap) {
          _controller.complete(controllerMap);
        },

        //---------------------- Pin a marker in the map -----------------------
        onTap: (locatin) async {
          markers.add(Marker(
              markerId: const MarkerId('New location'),
              position: LatLng(locatin.latitude, locatin.longitude)));

          List<Placemark> placemarks = await placemarkFromCoordinates(
              locatin.latitude, locatin.longitude);
          Placemark place = placemarks[0];
          final pinAddress =
              '${place.street},${place.subLocality},${place.subAdministrativeArea},${place.postalCode}';
          cityName = place.locality!;
          address = pinAddress;
          latitude = locatin.latitude;
          longitude = locatin.latitude;
          setState(() {});
        },
        //----------------------------------------------------------------------
      ),

      //--------------------------- Bottom Sheet -------------------------------
      bottomSheet: Form(
        key: _formNewAddressField,
        child: Container(
          height: context.getHeight(divide: 3.50),
          width: context.getWidth(),
          decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ContainerWidget(
                    containerHeight: context.getWidth(divide: 95),
                    containerWidth: context.getWidth(divide: 5),
                    contanierBorderRadius: 50,
                    containerColor: grey,
                  ),
                  height20,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: cityName ?? '',
                            textSize: 20,
                            textFontWeight: FontWeight.w700,
                          ),

                          //------------- get current user location ----------------
                          InkWell(
                            onTap: () {
                              getUserCurrentLocation().then((value) async {
                                latitude = value.latitude;
                                longitude = value.longitude;

                                List<Placemark> placemarks =
                                    await placemarkFromCoordinates(
                                        latitude, longitude);
                                Placemark place = placemarks[0];
                                cityName = place.locality;
                                address =
                                    '${place.street},${place.subLocality},${place.subAdministrativeArea},${place.postalCode}';
                                markers.add(
                                  Marker(
                                    markerId: const MarkerId('2'),
                                    position: LatLng(latitude, longitude),
                                    infoWindow: const InfoWindow(
                                        title: 'User Current Location'),
                                  ),
                                );
                                CameraPosition cameraPosition = CameraPosition(
                                    zoom: 14,
                                    target: LatLng(latitude, longitude));

                                final GoogleMapController controller =
                                    await _controller.future;
                                controller.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        cameraPosition));
                                setState(() {});
                              });
                            },
                            child: const TextWidget(
                              text: 'تحديد موقعك الحالي',
                              textColor: darkGrey,
                            ),
                          ),
                          //--------------------------------------------------------
                        ],
                      ),
                      height10,
                      TextWidget(text: address ?? ''),
                      height10,
                      TextFormFieldWidget(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'رجاءََ قم بكتابة عنوان لموقعك الجديد';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          controller: addressTitle,
                          labelText: 'عنوان الموقع',
                          hintText: 'ادخل عنوان لموقعك',
                          labelTextColor: grey,
                          cursorColor: grey,
                          controllerTextColor: dark1Green,
                          obscureText: false)
                    ],
                  ),
                  height20,

                  // ------------- Save User Location  in database -----------------
                  InkWell(
                    onTap: () {
                      showDialogAlertMessage(
                          context: context,
                          contentText: 'تم إضافة عنوانك الجديد بنجاح',
                          titleText: 'تم اضافة الموقع',
                          onPressed: () {
                            context.popScreen();
                          });
                      if (_formNewAddressField.currentState!.validate()) {
                        print('city name ');
                        print(cityName);
                        print('address');
                        print(address);
                        print('latitude');
                        print(latitude);
                        print('longitude');
                        print(longitude);
                        context.read<UserBloc>().add(AddNewAddress(
                            addressId: widget.address.id,
                            userId: widget.user.id,
                            address: address,
                            city: cityName,
                            latitude: latitude,
                            longitude: longitude,
                            addressTitle: addressTitle.text));

                        addressTitle.clear();
                      }
                    },
                    child: ContainerWidget(
                      containerHeight: 48,
                      containerWidth: context.getWidth(),
                      contanierBorderRadius: 10,
                      containerColor: green,
                      child: const Center(
                        child: TextWidget(
                          text: 'حفظ الموقع',
                          textColor: white,
                          textSize: 20,
                        ),
                      ),
                    ),
                  ),
                  height40
                  //----------------------------------------------------------------
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
