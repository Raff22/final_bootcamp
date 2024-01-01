import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/container_widget.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/models/address.dart';
import 'package:fazzah_user/models/user_model.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/views/user_main_views/blocks/user_bloc.dart';
import 'package:fazzah_user/views/user_main_views/blocks/user_state.dart';
import 'package:fazzah_user/views/user_main_views/more_screens/add_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPlacesScreen extends StatelessWidget {
  const MyPlacesScreen({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(
          context: context,
          title: 'عناويني',
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                context.popScreen();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded))),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return SizedBox(
                    height: context.getHeight(divide: 1.50),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: green,
                      ),
                    ),
                  );
                }
                if (state is AllUserAddressState) {
                  return SizedBox(
                    height: context.getHeight(divide: 1.35),
                    child: ListView.builder(
                      itemCount: state.address.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: ContainerWidget(
                            contanierBorderRadius: 10,
                            containerWidth: context.getWidth(),
                            containerColor: lightGreen,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                        text:
                                            state.address[index].addressTitle!,
                                        textColor: green,
                                        textSize: 18,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          context.pushScreen(
                                              screen: AddPlaceScreen(
                                            user: user,
                                            address: state.address[index],
                                          ));

                                          // context.read<UserBloc>().add(
                                          //     DeleteUserAddressEvent(
                                          //         state.address[index].id!));
                                        },
                                        icon: const Icon(
                                            Icons.edit_location_outlined),
                                        color: green,
                                      )
                                    ],
                                  ),
                                  TextWidget(
                                    text: state.address[index].address!,
                                    textColor: darkGrey,
                                  ),
                                  height20
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is ErrorState) {
                  return TextWidget(text: state.errorMessage);
                }
                return SizedBox(
                  height: context.getHeight(divide: 1.50),
                  child: const Center(
                    child: TextWidget(
                        textAlign: TextAlign.center,
                        text:
                            'لايوجد لديك أي عنوان يمكنك إضافة عنوان جديد بالنقر على إضافة عنوان '),
                  ),
                );
              },
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                final Address address = Address(
                    city: 'Riyadh',
                    address: 'RFHA7596,Al Hamra,Riyadh Principality,13216',
                    latitude: 24.774265,
                    longitude: 46.738586);

                context.pushScreen(
                    screen: AddPlaceScreen(
                  address: address,
                  user: user,
                ));
              },
              child: ContainerWidget(
                containerHeight: 48,
                containerWidth: context.getWidth(),
                contanierBorderRadius: 10,
                containerColor: green,
                child: const Center(
                  child: TextWidget(
                    text: 'إضافة عنوان',
                    textColor: white,
                    textSize: 20,
                  ),
                ),
              ),
            ),
            height20
          ],
        ),
      ),
    );
  }
}
