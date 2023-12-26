import 'package:fazzah_user/app_data/static_data.dart';
import 'package:fazzah_user/bloc/booking/booking_bloc.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/container_widget.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingDetailsView extends StatelessWidget {
  const BookingDetailsView({super.key, required this.providerInfo});
  final ProviderModel providerInfo;

  @override
  Widget build(BuildContext context) {
    List<bool> selected = List.generate(services.length, (index) => false);

    return Scaffold(
      appBar: createAppBar(
          title: "تفاصيل الحجز",
          context: context,
          leading: IconButton(
              onPressed: () {
                context.read<BookingBloc>().add(
                    RequestProviderRatingsEvent(providerId: providerInfo.id!));
                context.popScreen();
              },
              icon: const Icon(Icons.arrow_back_ios, size: 20, color: black))),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            height20,
            const TextWidget(
              text: "الخدمة",
              textSize: 22,
              textFontWeight: FontWeight.w500,
            ),
            BlocBuilder<BookingBloc, BookingState>(
              builder: (context, state) {
                if (state is ShowSelectedServiceState) {
                  selected = state.newSelected;
                }
                return ToggleButtons(
                    selectedColor: black,
                    fillColor: coldGreen,
                    splashColor: coldGreen,
                    direction: Axis.vertical,
                    isSelected: selected,
                    onPressed: (index) {
                      context
                          .read<BookingBloc>()
                          .add(SelectedServiceEvent(index: index));
                    },
                    children: List.generate(
                        services.length,
                        (index) => ServiceCheckBox(
                            serviceName: services[index],
                            state: selected[index])));
              },
            ),
            height20,
            const TextWidget(
              text: "ارفاق صورة الخلل (اختياري)",
              textSize: 22,
              textFontWeight: FontWeight.w500,
            ),
            Image.asset('assets/images/empty_image.png'),
            height20,
            const TextWidget(
              text: "اختيار موعد",
              textSize: 22,
              textFontWeight: FontWeight.w500,
            ),
            Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    shadow: grey,
                    primary: coldGreen, // <-- SEE HERE
                    onPrimary: black, // <-- SEE HERE
                    onSurface: black, // <-- SEE HERE
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: black, // button text color
                    ),
                  )),
              child: DatePickerDialog(
                  firstDate: DateTime.timestamp(), lastDate: DateTime(2055)),
            ),
            BlocBuilder<BookingBloc, BookingState>(
              builder: (context, state) {
                if (state is ShowProviderWorkingHoursState) {
                  return SizedBox(
                    width: context.getWidth(),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: List.generate(
                              hours.length,
                              (index) => HourWidget(
                                  hour: hours[index],
                                  isAvailable: state.hours
                                      .getHoursAvailabilityList()[index]))),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            height20,
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: "قيمة اليد العاملة",
                  textSize: 22,
                  textFontWeight: FontWeight.w500,
                ),
                TextWidget(
                  text: "١٢٥ رس",
                  textSize: 22,
                  textFontWeight: FontWeight.bold,
                  textColor: green,
                ),
              ],
            ),
            height20,
            const TextWidget(
              text: "طريقة الدفع",
              textSize: 22,
              textFontWeight: FontWeight.w500,
            ),
            height20,
            const PaymentMethodWidget(),
            height20,
            const TextWidget(
              text: "ملاحظة : هذه القيمة لا تشمل قيمة الادوات المطلوبة",
              textSize: 14,
              textColor: red,
            ),
            height20,
            ContainerWidget(
                contanierBorderRadius: 10,
                containerWidth: context.getWidth(),
                containerHeight: 48,
                containerColor: green,
                onPressed: () {},
                child: const Center(
                    child: TextWidget(
                  text: "تأكيد الحجز",
                  textSize: 25,
                  textColor: lightGrey,
                ))),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        height: 58,
        decoration: BoxDecoration(
            border: Border.all(color: grey),
            borderRadius: BorderRadius.circular(10)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          //HERE PAYMENT METHOD OBJECT
          Image.asset('assets/images/applepay.png'),
          InkWell(
            onTap: () {
              showBottomSheet(
                  context: context,
                  backgroundColor: white,
                  builder: (context) {
                    return SizedBox(
                      height: context.getHeight(divide: 3),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            height20,
                            Center(
                              child: ContainerWidget(
                                  contanierBorderRadius: 10,
                                  containerWidth: 366,
                                  containerHeight: 48,
                                  containerColor: green,
                                  onPressed: () {},
                                  child: const Center(
                                      child: TextWidget(
                                    text: "تغيير",
                                    textSize: 25,
                                    textColor: lightGrey,
                                  ))),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              width: 49,
              height: 36,
              decoration: BoxDecoration(
                  color: green, borderRadius: BorderRadius.circular(10)),
              child: const TextWidget(text: "تغيير", textColor: white),
            ),
          )
        ]));
  }
}

class HourWidget extends StatelessWidget {
  const HourWidget({
    super.key,
    required this.isAvailable,
    required this.hour,
  });
  final bool isAvailable;
  final String hour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
              padding: const EdgeInsets.all(7),
              color: isAvailable ? lightGreen : grey,
              child: TextWidget(text: hour, textSize: 20)),
        ),
      ),
    );
  }
}

class ServiceCheckBox extends StatelessWidget {
  const ServiceCheckBox(
      {super.key, required this.serviceName, required this.state});
  final String serviceName;
  final bool state;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: state,
            onChanged: (value) {},
            fillColor: null,
            activeColor: black),
        TextWidget(
          text: serviceName,
          textSize: 22,
        ),
      ],
    );
  }
}
