import 'package:fazzah_user/bloc/booking/booking_bloc.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/views/booking_views/booking_widgets/notfound_widget.dart';
import 'package:fazzah_user/views/booking_views/booking_widgets/provider_view_widgets.dart';
import 'package:fazzah_user/views/provider_view/provider_widget/drawer_provider_widget.dart';
import 'package:fazzah_user/views/provider_view/provider_widget/provider_rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProviderRatingView extends StatelessWidget {
  const ProviderRatingView({super.key, this.providerModel});
  final ProviderModel? providerModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(
          context: context, title: 'اراء العملاء', centerTitle: true),
      drawer: DrawerProviderWidget(providerModel: providerModel),
      body: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          if (state is ShowProviderRatingsState) {
            if (state.ratings.isEmpty) {
              return const Center(
                  child: NotFoundWidget(message: "لا يوجد تقيم حتى الان"));
            }
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  providerModel!.rateAverage != null
                      ? RatingAverageWidget(
                          providerModel: providerModel!, ratings: state.ratings)
                      : const Text(""),
                  height20,
                  Expanded(
                    child: ListView.separated(
                      itemCount: state.ratings.length,
                      itemBuilder: (context, index) =>
                          MyRatingWidget(ratingInfo: state.ratings[index]),
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is BookingLoadingState) {
            return const Center(child: CircularProgressIndicator(color: green));
          } else if (state is BookingErrorState) {
            return Center(child: Text(state.error));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
