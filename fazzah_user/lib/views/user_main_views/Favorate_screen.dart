import 'package:fazzah_user/app_data/static_data.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/views/user_main_views/blocks/fav_bloc/fav_bloc.dart';
import 'package:fazzah_user/views/user_main_views/blocks/fav_bloc/fav_state.dart';
import 'package:fazzah_user/views/user_main_views/coustom_wedgets/user_wedgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavorateScreen extends StatelessWidget {
  const FavorateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        mainScreenAppbar(title: "مفضلتي"),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 370,
          height: 200,
          child: ListView.builder(
            itemCount: workerslist.length,
            itemBuilder: (context, index) {
              return BlocBuilder<FavBloc, FavState>(
                builder: (context, state) {
                  bool isFav = false;
                  if (state is FavSelected) {
                    isFav = state.isFav;
                  }
                  return isFav ? workerslist[index] : Container();
                },
              );
            },
          ),
        )
      ],
    ));
  }
}
