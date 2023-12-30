import 'package:fazzah_user/app_data/static_data.dart';
import 'package:fazzah_user/bloc/booking/booking_bloc.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/container_widget.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/models/payment_method.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/working_hours_model.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/views/booking_views/booking_widgets/hour_widget.dart';
import 'package:fazzah_user/views/booking_views/booking_widgets/payment_method.dart';
import 'package:fazzah_user/views/booking_views/booking_widgets/price_widget.dart';
import 'package:fazzah_user/views/booking_views/booking_widgets/services_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingDetailsView extends StatelessWidget {
  const BookingDetailsView({super.key, required this.providerInfo});
  final ProviderModel providerInfo;

  @override
  Widget build(BuildContext context) {
    List<bool> selectedServices =
        List.generate(services.length, (index) => false);
    List<bool> selectedHours = List.generate(hours.length, (index) => false);
    WorkingHours availableHours = WorkingHours();
    List<bool> selectedPayments = [];
    List<PaymentMethod> paymentMethods = [];

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
                  selectedServices = state.newSelected;
                }
                return ToggleButtons(
                    selectedColor: black,
                    fillColor: coldGreen,
                    splashColor: coldGreen,
                    direction: Axis.vertical,
                    isSelected: selectedServices,
                    onPressed: (index) {
                      context
                          .read<BookingBloc>()
                          .add(SelectedServiceEvent(index: index));
                    },
                    children: List.generate(
                        services.length,
                        (index) => ServiceCheckBox(
                            serviceName: services[index],
                            state: selectedServices[index])));
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
                  availableHours = state.hours;
                  context
                      .read<BookingBloc>()
                      .add(RequestUserPaymentMethodsEvent());
                }
                if (state is ShowSelectedHourState) {
                  selectedHours = state.newSelected;
                }
                return SizedBox(
                  width: context.getWidth(),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ToggleButtons(
                        selectedBorderColor: Colors.transparent,
                        selectedColor: black,
                        isSelected: selectedHours,
                        onPressed: (index) {
                          if (availableHours
                              .getHoursAvailabilityList()[index]) {
                            context
                                .read<BookingBloc>()
                                .add(SelectedHourEvent(index: index));
                          }
                        },
                        children: List.generate(
                            hours.length,
                            (index) => HourWidget(
                                hour: hours[index],
                                isSelected: selectedHours[index],
                                isAvailable: availableHours
                                    .getHoursAvailabilityList()[index]))),
                  ),
                );
              },
            ),
            height20,
            PriceWidget(priceRange: providerInfo.priceRange ?? "100-100"),
            height20,
            const TextWidget(
              text: "اختر طريقة الدفع",
              textSize: 22,
              textFontWeight: FontWeight.w500,
            ),
            height20,
            BlocBuilder<BookingBloc, BookingState>(
              builder: (context, state) {
                if (state is ShowUserPaymentMethodsState) {
                  selectedPayments = state.selectedPayments;
                  paymentMethods = state.paymentMethodsList;
                }
                return ToggleButtons(
                    selectedColor: black,
                    fillColor: coldGreen,
                    splashColor: coldGreen,
                    direction: Axis.vertical,
                    isSelected: selectedPayments,
                    onPressed: (index3) {
                      context
                          .read<BookingBloc>()
                          .add(SelectPaymentMethodEvent(index: index3));
                    },
                    children: List.generate(
                        paymentMethods.length,
                        (index2) => PaymentMethodWidget(
                            method: paymentMethods[index2], showOnTap: false)));
              },
            ),
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
