import 'package:fazzah_user/app_data/static_data.dart';
import 'package:fazzah_user/database/get_data.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/views/user_main_views/blocks/fav_bloc/fav_bloc.dart';
import 'package:fazzah_user/views/user_main_views/blocks/fav_bloc/fav_state.dart';
import 'package:fazzah_user/views/user_main_views/coustom_wedgets/user_wedgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavorateScreen extends StatefulWidget {
  const FavorateScreen({super.key});

  @override
  State<FavorateScreen> createState() => _FavorateScreenState();
}

class _FavorateScreenState extends State<FavorateScreen> {
  ProviderModel? currentProvider;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPatientAndDoctorData();
  }

  // Future<void> loadPatientAndDoctorData() async {
  //   try {
  //     var provider = await SupaGetAndDelete()
  //         .getProvider("98a938ed-08c1-4a37-861f-5c0bc6567412");

  //     if (provider != null) {
  //       setState(() {
  //         currentProvider = provider;

  //         isLoading = false;
  //       });
  //     }
  //   } catch (error) {
  //     setState(() => isLoading = false);
  //     print('Error loading data: $error');
  //   }
  // }

  Future<void> loadPatientAndDoctorData() async {
    try {
      var provider = await SupaGetAndDelete().getAllProviders();

      if (provider != null) {
        setState(() {
          currentProvider = provider;

          isLoading = false;
        });
      }
    } catch (error) {
      setState(() => isLoading = false);
      print('Error loading data: $error');
    }
  }

  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
        body: Column(
      children: [
        mainScreenAppbar(title: "مفضلتي"),
        SizedBox(
          height: 20,
        ),
        Text(currentProvider!.name!),

        // SizedBox(
        //   width: 370,
        //   height: 200,
        //   child: ListView.builder(
        //     itemCount: workerslist.length,
        //     itemBuilder: (context, index) {
        //       return BlocBuilder<FavBloc, FavState>(
        //         builder: (context, state) {
        //           bool isFav = false;
        //           if (state is FavSelected) {
        //             isFav = state.isFav;
        //           }
        //           return isFav ? workerslist[index] : Container();
        //         },
        //       );

        //     },
        //   ),
        // )
      ],
    ));
  }
}
