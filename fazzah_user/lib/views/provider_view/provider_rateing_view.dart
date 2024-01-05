import 'package:fazzah_user/utils/imports.dart';

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
