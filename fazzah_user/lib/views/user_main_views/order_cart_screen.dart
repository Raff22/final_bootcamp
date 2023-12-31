import 'package:fazzah_user/bloc/order_bloc/order_bloc.dart';
import 'package:fazzah_user/bloc/order_bloc/order_event.dart';
import 'package:fazzah_user/bloc/order_bloc/order_state.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/models/order_model.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/utils/helpers/map_splitter.dart';
import 'package:fazzah_user/views/booking_views/booking_widgets/notfound_widget.dart';
import 'package:fazzah_user/views/user_main_views/coustom_wedgets/user_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCartScreen extends StatefulWidget {
  const OrderCartScreen({super.key});

  @override
  State<OrderCartScreen> createState() => _OrderCartScreenState();
}

class _OrderCartScreenState extends State<OrderCartScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabsController;
  @override
  void initState() {
    super.initState();
    tabsController = TabController(length: 2, vsync: this);
    context.read<OrderBloc>().add(RequestAllUserOrdersEvent());
  }

  @override
  void dispose() {
    tabsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(context: context, title: "طلباتي"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              width: context.getWidth(
                  divide: 1.02), // Ensure this method is defined
              height: 70,
              child: TabBar(
                  indicatorColor: green,
                  labelStyle:
                      const TextStyle(fontSize: 20, fontFamily: "SF-Arabic"),
                  labelColor: green,
                  unselectedLabelColor: grey,
                  controller: tabsController,
                  tabs: const [
                    Tab(text: "طلباتي القادمة"),
                    Tab(text: "طلباتي السابقة"),
                  ]),
            ),
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state is OrderLoadingState) {
                  return const Center(
                      child: CircularProgressIndicator(color: green));
                } else if (state is ShowUserOrdersState) {
                  final List<Order> ordersDone =
                      splitMapToKeyList(state.isDoneMap);
                  final List<ProviderModel> providersDone =
                      splitMapToValueList(state.isDoneMap);
                  final List<Order> ordersNotDone =
                      splitMapToKeyList(state.notDoneMap);
                  final List<ProviderModel> providersNotDone =
                      splitMapToValueList(state.notDoneMap);
                  return Expanded(
                    child: TabBarView(
                      controller: tabsController,
                      children: [
                        orderListView(
                            providersList: providersNotDone,
                            orderList: ordersNotDone),
                        orderListView(
                            providersList: providersDone, orderList: ordersDone)
                      ],
                    ),
                  );
                } else if (state is OrderErrorState) {
                  return Center(child: Text(state.error));
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget orderListView(
      {required List<ProviderModel> providersList,
      required List<Order> orderList}) {
    if (orderList.isEmpty) {
      return const NotFoundWidget(message: "لا توجد طلبات في الوقت الحالي");
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: ListView.separated(
        itemCount: providersList.length,
        itemBuilder: (context, index) => UserOrderCard(
            provider: providersList[index], order: orderList[index]),
        separatorBuilder: (BuildContext context, int index) => height20,
      ),
    );
  }
}
