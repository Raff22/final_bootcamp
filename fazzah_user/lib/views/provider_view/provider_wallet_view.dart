import 'package:fazzah_user/bloc/booking/booking_bloc.dart';
import 'package:fazzah_user/bloc/payments_bloc/payments_event.dart';
import 'package:fazzah_user/bloc/provider_wallet/provider_wallet_bloc.dart';
import 'package:fazzah_user/bloc/provider_wallet/provider_wallet_event.dart';
import 'package:fazzah_user/bloc/provider_wallet/provider_wallet_state.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/database/update_data.dart';
import 'package:fazzah_user/global/global_widget/container_widget.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/views/provider_view/provider_widget/drawer_provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProviderWalletView extends StatelessWidget {
  const ProviderWalletView({super.key, this.providerModel});
  final ProviderModel? providerModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar:
            createAppBar(context: context, title: 'المحفظة', centerTitle: true),
        drawer: DrawerProviderWidget(providerModel: providerModel),
        body: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 200, top: 20, bottom: 20),
              child: Text("رصيدك الحالي", style: TextStyle(fontSize: 25)),
            ),
            BlocBuilder<WalletBloc, WalletState>(
              builder: (context, state) {
                if (state is ShowAllWalletmentsState) {
                  return Container();
                }
                return Container(
                  width: 350,
                  height: 70,
                  decoration: BoxDecoration(
                      color: lightGrey,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "${providerModel!.wallet ?? ""} ريال",
                      style: TextStyle(fontSize: 25, color: black),
                    ),
                  ),
                );
              },
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(30),
              child: ContainerWidget(
                  contanierBorderRadius: 10,
                  containerWidth: context.getWidth(),
                  containerHeight: 48,
                  containerColor: green,
                  onPressed: () {
                    _showBottomSheet(context, providerModel);
                  },
                  child: Center(
                      child: TextWidget(
                    text: " تحويل لحسابك البنكي",
                    textSize: 25,
                    textColor: lightGrey,
                  ))),
            ),
          ],
        )),
      ),
    );
  }
}

void _showBottomSheet(BuildContext context, ProviderModel? providerModel) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext bc) {
      final nameController = TextEditingController();
      final ibanController = TextEditingController();
      final bankNameController = TextEditingController();
      final formKey = GlobalKey<FormState>(); // Add a key for the form

      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: context.getHeight(divide: 2),
            padding: EdgeInsets.all(20),
            child: Form(
              // Wrap your Column with a Form widget
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "الاسم",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال الاسم';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: ibanController,
                    decoration: InputDecoration(
                      labelText: "حساب الايبان",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 3) {
                        return 'الرجاء إدخال حساب الايبان';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: bankNameController,
                    decoration: InputDecoration(
                      labelText: "اسم البنك",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 3) {
                        return 'الرجاء إدخال اسم البنك';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: ContainerWidget(
                        contanierBorderRadius: 10,
                        containerWidth: context.getWidth(),
                        containerHeight: 48,
                        containerColor: green,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // Only proceed if the form is valid
                            Navigator.pop(context);
                            providerModel!.wallet = 0;
                            context
                                .read<WalletBloc>()
                                .add(RequestallWalletmentsEvent());
                          }
                        },
                        child: Center(
                            child: TextWidget(
                          text: "تحويل لحسابك البنكي",
                          textSize: 25,
                          textColor: lightGrey,
                        ))),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
