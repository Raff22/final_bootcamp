import 'package:fazzah_user/bloc/order_bloc/order_bloc.dart';
import 'package:fazzah_user/bloc/order_bloc/order_event.dart';
import 'package:fazzah_user/bloc/order_bloc/order_state.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/database/get_data.dart';
import 'package:fazzah_user/models/order_model.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/views/user_main_views/coustom_wedgets/user_wedgets.dart';
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
    context.read<OrderBloc>().add(RequestallProvidersEvent());
  }

  @override
  void dispose() {
    tabsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          mainScreenAppbar(title: "طلباتي"), // Ensure this is a valid AppBar
          SizedBox(
            width:
                context.getWidth(divide: 1.02), // Ensure this method is defined
            height: 70,
            child: TabBar(
                indicatorColor: green,
                labelStyle:
                    const TextStyle(fontSize: 20, fontFamily: "SF-Arabic"),
                labelColor: green,
                unselectedLabelColor: grey,
                controller: tabsController,
                tabs: const [
                  Tab(text: "طلباتي القادمه"),
                  Tab(text: "الخدمات"),
                ]),
          ),
          Expanded(
            child: TabBarView(
              controller: tabsController,
              children: [
                buildUpcomingOrdersTab(context),
                buildServicesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUpcomingOrdersTab(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderLoadingState) {
          return const Center(child: CircularProgressIndicator(color: green));
        } else if (state is ShowAllProvidersState) {
          if (state.isdonelist.isEmpty) {
            return Container();
          }
          return buildProvidersList(context, state.isdonelist);
        } else if (state is OrderErrorState) {
          return Center(child: Text(state.error));
        }
        return const Center(child: Text('No data available'));
      },
    );
  }

  Widget buildProvidersList(
      BuildContext context, List<ProviderModel> providersList) {
    return ListView.separated(
      itemCount: providersList.length,
      itemBuilder: (context, index) =>
          WorkerCard(providerInfo: providersList[index]),
      separatorBuilder: (BuildContext context, int index) => height20,
    );
  }

  Widget buildServicesTab() {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderLoadingState) {
          return const Center(child: CircularProgressIndicator(color: green));
        } else if (state is ShowAllProvidersState) {
          if (state.isdonelist.isEmpty) {
            return Container();
          }
          return buildProvidersList(context, state.notdonelist);
        } else if (state is OrderErrorState) {
          return Center(child: Text(state.error));
        }
        return const Center(child: Text('No data available'));
      },
    );
  }
}
