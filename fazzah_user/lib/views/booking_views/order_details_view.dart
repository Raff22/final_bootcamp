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
import 'package:fazzah_user/views/booking_views/booking_widgets/payment_method.dart';
import 'package:fazzah_user/views/booking_views/tracking_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                          ContactWidget(icon: Icons.chat, onpressed: () {}),
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
                        Container(
                            height: 25,
                            width: 65,
                            decoration: BoxDecoration(
                              color: lightGrey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: TextWidget(
                                  text: "${order.orderStatus}",
                                  textColor: green,
                                  textSize: 16),
                            ))
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
                      ? ContainerWidget(
                          contanierBorderRadius: 10,
                          containerWidth: context.getWidth(),
                          containerHeight: 48,
                          containerColor: green,
                          onPressed: () {},
                          child: const Center(
                              child: TextWidget(
                            text: "الدفع الان",
                            textSize: 25,
                            textColor: lightGrey,
                          )))
                      : const Text(""),
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
