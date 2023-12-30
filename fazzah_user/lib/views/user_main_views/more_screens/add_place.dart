
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';

class AddPlaceScreen extends StatelessWidget {
  const AddPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(
          context: context,
          title: 'إضافة عنوان',
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                context.popScreen();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded))),
      body: Column(
        children: [
          IconButton(
              onPressed: () {
                // insert 

                // SupabaseInsetr().addNewAddressUser(
                //     userId: '8bc48f85-ab08-4d48-8c17-310a602ea808',
                //     address: 'RFHA7596,Al Hamra,Riyadh Principality,13216',
                //     city: 'Riyadh',
                //     latitude: 24.774265,
                //     longitude: 46.738586,
                //     addressTitle: 'المنزل');

                // get 

                // SupaGetAndDelete().getAllAddressbyUserID(userId: 'userId');

                // detele
                // SupabaseDelete().deleteUserAddress(addressId: 5);
              },
              icon: Icon(Icons.ac_unit))
        ],
      ),
    );
  }
}
