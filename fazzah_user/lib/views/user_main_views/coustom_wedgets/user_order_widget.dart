import 'package:cached_network_image/cached_network_image.dart';
import 'package:fazzah_user/bloc/order_bloc/order_bloc.dart';
import 'package:fazzah_user/bloc/order_bloc/order_event.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/models/order_model.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/views/booking_views/booking_widgets/status_container.dart';
import 'package:fazzah_user/views/booking_views/order_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserOrderCard extends StatelessWidget {
  const UserOrderCard({super.key, required this.provider, required this.order});
  final ProviderModel provider;
  final Order order;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<OrderBloc>().add(RequestOrderRelaitedInfoEvent(
            paymentMethodID: order.paymentMethod!, addressID: order.address!));
        context.pushScreen(
            screen: OrderDetailsView(order: order, provider: provider));
      },
      child: Container(
          height: context.getHeight(divide: 7),
          width: context.getWidth(divide: 1.1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xffeff0eb),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: (provider.providerImage == null ||
                              provider.providerImage!.isEmpty)
                          ? Image.asset('assets/images/Logo_provider.png',
                              width: 96, height: 96, fit: BoxFit.fill)
                          : CachedNetworkImage(
                              width: 96,
                              height: 96,
                              imageUrl: provider.providerImage!,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(color: green),
                              fit: BoxFit.fill)),
                  width20,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(" الخدمة: ${order.orderType ?? ""} ",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Text(" الفني: ${provider.name ?? ""} "),
                      Text(
                        "السعر: ${order.total.toString()}",
                        style: const TextStyle(fontWeight: FontWeight.w300),
                      ),
                      Text(
                        "التاريخ: ${order.orderDate ?? ""}",
                        style: const TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  OrderStatusWidget(status: "${order.orderStatus}"),
                ],
              ),
            ),
          )),
    );
  }
}
