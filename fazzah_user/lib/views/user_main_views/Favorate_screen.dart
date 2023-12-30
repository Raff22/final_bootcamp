import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/views/booking_views/booking_widgets/notfound_widget.dart';
import 'package:fazzah_user/views/user_main_views/blocks/fav_bloc/fav_bloc.dart';
import 'package:fazzah_user/views/user_main_views/blocks/fav_bloc/fav_event.dart';
import 'package:fazzah_user/views/user_main_views/blocks/fav_bloc/fav_state.dart';
import 'package:fazzah_user/views/user_main_views/coustom_wedgets/user_wedgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavorateScreen extends StatelessWidget {
  const FavorateScreen({super.key});

  // ProviderModel? currentProvider;
  @override
  Widget build(BuildContext context) {
    context.read<FavBloc>().add(RequestFavList());
    return Scaffold(
        appBar: createAppBar(context: context, title: "مفضلتي"),
        body: BlocBuilder<FavBloc, FavState>(builder: (context, state) {
          if (state is FavoriteLoadingState) {
            return const Center(
                child: CircularProgressIndicator(color: coldGreen));
          }
          if (state is FavoriteErrorState) {
            return Center(child: Text(state.error));
          }
          if (state is ShowFavoritesState) {
            if (state.favList.isEmpty) {
              return const Center(
                  child: NotFoundWidget(message: "المفضلة فارغة"));
            }
            return Padding(
              padding: const EdgeInsets.all(
                20.0,
              ),
              child: SizedBox(
                width: context.getWidth(),
                height: context.getHeight(),
                child: ListView.separated(
                    itemCount: state.favList.length,
                    itemBuilder: (context, index) => WorkerCard(
                        isFav: true, providerInfo: state.favList[index]),
                    separatorBuilder: (BuildContext context, int index) {
                      return height20;
                    }),
              ),
            );
          }
          return Container();
        }));
  }
}
