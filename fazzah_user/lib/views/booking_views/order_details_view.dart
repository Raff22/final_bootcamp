import 'package:cached_network_image/cached_network_image.dart';
import 'package:fazzah_user/bloc/order_bloc/order_bloc.dart';
import 'package:fazzah_user/bloc/order_bloc/order_event.dart';
import 'package:fazzah_user/bloc/order_bloc/order_state.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/container_widget.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/models/order_model.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/utils/helpers/show_dialog_message.dart';
import 'package:fazzah_user/utils/helpers/show_message_green.dart';
import 'package:fazzah_user/views/booking_views/booking_widgets/contact_widget.dart';
import 'package:fazzah_user/views/booking_views/booking_widgets/payment_method.dart';
import 'package:fazzah_user/views/booking_views/booking_widgets/rating_bottom_sheet.dart';
import 'package:fazzah_user/views/booking_views/booking_widgets/status_container.dart';
import 'package:fazzah_user/views/chat_views/chat_widgets/user_chat_screem.dart';
import 'package:fazzah_user/views/user_main_views/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView(
      {super.key, required this.order, required this.provider});
  final Order order;
  final ProviderModel provider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(
          title: "تفاصيل الطلب",
          context: context,
          leading: IconButton(
              onPressed: () {
                context.read<OrderBloc>().add(RequestAllUserOrdersEvent());
                context.popScreen();
              },
              icon: const Icon(Icons.arrow_back_ios, size: 20, color: black))),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is ShowOrderRelatiedInfo) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  SizedBox(
                    width: context.getWidth() - 40,
                    child: ListTile(
                      leading: ClipOval(
                        child: (provider.providerImage == null ||
                                provider.providerImage!.isEmpty)
                            ? Image.asset(
                                'assets/images/Logo_provider.png',
                                height: 50,
                                width: 50,
                              )
                            : CachedNetworkImage(
                                imageUrl: provider.providerImage!,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(
                                        color: green),
                                height: 50,
                                width: 50,
                              ),
                      ),
                      title: TextWidget(
                          text: provider.name!,
                          textSize: 20,
                          textFontWeight: FontWeight.w500),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ContactWidget(
                              icon: Icons.chat,
                              onpressed: () {
                                context.pushScreen(
                                    screen: UserchatScreen(
                                  provider: provider,
                                ));
                              }),
                          width20,
                          ContactWidget(icon: Icons.phone, onpressed: () {}),
                        ],
                      ),
                    ),
                  ),
                  height20,
                  const Divider(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextWidget(text: "حالة الطلب", textSize: 20),
                        OrderStatusWidget(status: "${order.orderStatus}"),
                      ]),
                  height20,
                  const TextWidget(text: "رقم الطلب", textSize: 20),
                  TextWidget(text: "${order.id}", textSize: 15),
                  height20,
                  const TextWidget(text: "تاريخ الحجز", textSize: 20),
                  TextWidget(text: "${order.orderDate}", textSize: 15),
                  height20,
                  const TextWidget(text: "وقت الحجز", textSize: 20),
                  TextWidget(text: "${order.orderTime}", textSize: 15),
                  height20,
                  const TextWidget(text: "نوع الخدمة", textSize: 20),
                  TextWidget(text: "${order.orderType}", textSize: 15),
                  height20,
                  const TextWidget(text: "الموقع", textSize: 20),
                  TextWidget(text: "${state.address.address}", textSize: 15),
                  height20,
                  const TextWidget(text: "طريقة الدفع", textSize: 20),
                  PaymentMethodWidget(
                      method: state.paymentMethod, showAdd: false),
                  const Divider(),
                  const TextWidget(text: "قيمة اليد العاملة", textSize: 20),
                  TextWidget(text: "${order.total}", textSize: 15),
                  height20,
                  order.isDone! == false
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: BlocListener<OrderBloc, OrderState>(
                            listener: (context, state) {
                              if (state is PaymentCompletedSuccessfully) {
                                context.removeUnitl(
                                    screen: NavBar(
                                        user: state.user,
                                        provider: provider,
                                        navshowRating: true));
                                showMessageDialog(
                                    context: context,
                                    message: "شكرا لك ، تم الدفع بنجاح.");
                              }
                            },
                            child: ContainerWidget(
                                contanierBorderRadius: 10,
                                containerWidth: context.getWidth(),
                                containerHeight: 48,
                                containerColor: green,
                                onPressed: () {
                                  context.read<OrderBloc>().add(PayingEvent(
                                      order: order, provider: provider));
                                },
                                child: const Center(
                                    child: TextWidget(
                                  text: "الدفع الان",
                                  textSize: 20,
                                  textColor: lightGrey,
                                ))),
                          ),
                        )
                      : const Text(""),
                  BlocListener<OrderBloc, OrderState>(
                    listener: (context, state) {
                      if (state is DeletedOrderSuccessfully) {
                        context.removeUnitl(
                            screen: NavBar(user: state.user, index: 2));
                        showMessageDialog(
                            context: context, message: "تم حذف الطلب");
                      }
                    },
                    child: ContainerWidget(
                        contanierBorderRadius: 10,
                        containerWidth: context.getWidth(),
                        containerHeight: 48,
                        containerColor: grey,
                        onPressed: () {
                          print("dalete");
                          showDialogAlertMessage(
                              context: context,
                              contentText: 'هل انت متأكد من حذف الطلب؟',
                              titleText: 'حذف الطلب',
                              onPressed: () {
                                context
                                    .read<OrderBloc>()
                                    .add(DeleteOrderEvent(orderId: order.id!));
                                context.popScreen();
                              });
                        },
                        child: const Center(
                            child: TextWidget(
                          text: "حذف الطلب",
                          textSize: 20,
                          textColor: black,
                        ))),
                  )
                ],
              ),
            );
          } else if (state is OrderLoadingState) {
            return const Center(
                child: CircularProgressIndicator(color: lightGreen));
          } else if (state is OrderErrorState) {
            return Center(child: Text(state.error));
          }
          return Container();
        },
      ),
    );
  }
}
