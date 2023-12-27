import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/views/provider_view/provider_widget/drawer_provider_widget.dart';
import 'package:flutter/material.dart';

class ProviderBookingRequestsView extends StatelessWidget {
  const ProviderBookingRequestsView({super.key, this.providerModel});
  final ProviderModel? providerModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          createAppBar(context: context, title: 'الطلبات', centerTitle: true),
      drawer: DrawerProviderWidget(providerModel: providerModel),
      body: SafeArea(
        child: Center(
          child: Text('الطلبات'),
        ),
      ),
    );
  }
}
