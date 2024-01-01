import 'package:fazzah_user/bloc/order_bloc/order_bloc.dart';
import 'package:fazzah_user/bloc/order_bloc/order_event.dart';
import 'package:fazzah_user/bloc/order_bloc/order_state.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/models/order_model.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/user_model.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/utils/helpers/map_splitter.dart';
import 'package:fazzah_user/views/booking_views/booking_widgets/notfound_widget.dart';
import 'package:fazzah_user/views/provider_view/provider_widget/drawer_provider_widget.dart';
import 'package:fazzah_user/views/provider_view/provider_widget/provider_order_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProviderBookingRequestsView extends StatefulWidget {
  const ProviderBookingRequestsView({super.key, this.providerModel});
  final ProviderModel? providerModel;

  @override
  State<ProviderBookingRequestsView> createState() =>
      _ProviderBookingRequestsViewState();
}

class _ProviderBookingRequestsViewState
    extends State<ProviderBookingRequestsView>
    with SingleTickerProviderStateMixin {
  late TabController tabsController;
  @override
  void initState() {
    super.initState();
    tabsController = TabController(length: 2, vsync: this);
    context.read<OrderBloc>().add(RequestAllProviderOrdersEvent());
  }

  @override
  void dispose() {
    tabsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerProviderWidget(providerModel: widget.providerModel),
      appBar: createAppBar(context: context, title: "الطلبات"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
            Expanded(
              child: BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  if (state is OrderLoadingState) {
                    return const Center(
                        child: CircularProgressIndicator(color: green));
                  } else if (state is ShowProviderOrdersState) {
                    final List<Order> ordersDone =
                        splitMapToKeyList(state.isDoneMap);
                    final List<UserModel> usersDone =
                        splitMapToValueList(state.isDoneMap);
                    final List<Order> ordersNotDone =
                        splitMapToKeyList(state.notDoneMap);
                    final List<UserModel> usersNotDone =
                        splitMapToValueList(state.notDoneMap);
                    return TabBarView(
                      controller: tabsController,
                      children: [
                        orderListViewP(
                            usersList: usersNotDone, orderList: ordersNotDone),
                        orderListViewP(
                            usersList: usersDone, orderList: ordersDone)
                      ],
                    );
                  } else if (state is OrderErrorState) {
                    return Center(child: Text(state.error));
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget orderListViewP(
      {required List<UserModel> usersList, required List<Order> orderList}) {
    if (usersList.isEmpty) {
      return const NotFoundWidget(message: "لا توجد طلبات في الوقت الحالي");
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
      child: SizedBox(
        width: context.getWidth(divide: 1.02),
        height: context.getHeight(),
        child: ListView.separated(
          itemCount: orderList.length,
          itemBuilder: (context, index) => ProviderOrderCard(
              user: usersList[index], order: orderList[index]),
          separatorBuilder: (BuildContext context, int index) => height20,
        ),
      ),
    );
  }
}
