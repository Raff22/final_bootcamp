import 'package:fazzah_user/bloc/booking/booking_bloc.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/search_bar.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/views/booking_views/provider_view_screen.dart';
import 'package:fazzah_user/views/user_main_views/coustom_wedgets/user_wedgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProvidersScreen extends StatelessWidget {
  const ProvidersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BookingBloc>().add(RequestProvidersEvent());
    print("1");
    return Scaffold(
        appBar: createAppBar(
            title: "الفنيين",
            context: context,
            leading: IconButton(
                onPressed: () {
                  context.popScreen();
                },
                icon:
                    const Icon(Icons.arrow_back_ios, size: 20, color: black))),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              height20,
              const SearchBarWidget(hint: "ابحث عن فني"),
              height20,
              BlocBuilder<BookingBloc, BookingState>(
                builder: (context, state) {
                  if (state is BookingLoadingState) {
                    return const Center(
                        child: CircularProgressIndicator(color: green));
                  } else if (state is ShowAllProvidersState) {
                    print("4");
                    return SizedBox(
                      width: context.getWidth(),
                      height: context.getHeight(),
                      child: ListView.separated(
                          itemCount: state.providersList.length,
                          itemBuilder: (context, index) => WorkerCard(
                              providerInfo: state.providersList[index]),
                          separatorBuilder: (BuildContext context, int index) {
                            return height20;
                          }),
                    );
                  } else if (state is BookingErrorState) {
                    return Center(child: Text(state.error));
                  }
                  return Container();
                },
              )
            ],
          ),
        ));
  }
}
