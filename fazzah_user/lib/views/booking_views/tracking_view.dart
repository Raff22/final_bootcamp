import 'package:fazzah_user/bloc/chat_bloc/chat_bloc.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/container_widget.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/views/booking_views/booking_widgets/contact_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackingView extends StatelessWidget {
  const TrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: BottomSheet(
            showDragHandle: true,
            backgroundColor: white,
            onClosing: () {},
            builder: (context) {
              return SizedBox(
                height: context.getHeight(divide: 5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ListTile(
                        leading: SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.asset('assets/images/Logo.png')),
                        title: const TextWidget(
                          text: "أحمد نور",
                          textSize: 22,
                        ),
                        subtitle: const Text("الوقت المتوقع للوصول : ٣ دقائق"),
                        trailing: Wrap(
                          spacing: 10,
                          children: [
                            BlocBuilder<ChatBloc, ChatState>(
                              builder: (context, state) {
                                if (state is GetUsersSuccessedState) {
                                  return ContactWidget(
                                      icon: Icons.chat,
                                      onpressed: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             ChatScreen(
                                        //                 provider: state
                                        //                     .providera.first)));
                                      });
                                } else if (state is ErrorGetUsersState) {
                                  return const Text("error!!");
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                            ContactWidget(icon: Icons.phone, onpressed: () {}),
                          ],
                        ),
                      ),
                      height20,
                      Center(
                        child: ContainerWidget(
                            contanierBorderRadius: 10,
                            containerWidth: 366,
                            containerHeight: 48,
                            containerColor: grey,
                            onPressed: () {},
                            child: const Center(
                                child: TextWidget(
                              text: "الدفع الآن",
                              textSize: 25,
                              textColor: lightGrey,
                            ))),
                      ),
                    ],
                  ),
                ),
              );
            }),
        appBar: createAppBar(
            title: "تتبع الحجز",
            context: context,
            leading: IconButton(
                onPressed: () {
                  context.popScreen();
                },
                icon:
                    const Icon(Icons.arrow_back_ios, size: 20, color: black))),
        body: Image.asset('assets/images/map_placeholder.png'));
  }
}