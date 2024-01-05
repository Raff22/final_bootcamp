import 'package:fazzah_user/utils/imports.dart';

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
