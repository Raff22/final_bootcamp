import 'package:fazzah_user/app_data/static_data.dart';
import 'package:fazzah_user/bloc/booking/booking_bloc.dart';
import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/container_widget.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:fazzah_user/models/address.dart';
import 'package:fazzah_user/models/payment_method.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/working_hours_model.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/extentions/size_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/utils/helpers/loading_func.dart';
import 'package:fazzah_user/utils/helpers/show_message_green.dart';
import 'package:fazzah_user/utils/helpers/snackbar_mess.dart';
import 'package:fazzah_user/views/booking_views/booking_widgets/address_widget.dart';
import 'package:fazzah_user/views/booking_views/booking_widgets/hour_widget.dart';
import 'package:fazzah_user/views/booking_views/booking_widgets/payment_method.dart';
import 'package:fazzah_user/views/booking_views/booking_widgets/price_widget.dart';
import 'package:fazzah_user/views/booking_views/booking_widgets/services_checkbox.dart';
import 'package:fazzah_user/views/user_main_views/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

class BookingDetailsView extends StatelessWidget {
  const BookingDetailsView({super.key, required this.providerInfo});
  final ProviderModel providerInfo;

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    List<bool> selectedServices =
        List.generate(services.length, (index) => false);
    List<bool> selectedHours = List.generate(hours.length, (index) => false);
    WorkingHours availableHours = WorkingHours();
    List<bool> selectedPayments = [];
    List<PaymentMethod> paymentMethods = [];
    List<bool> selectedAddresses = [];
    List<Address> addresses = [];

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
            SizedBox(
              height: 200,
              child: DatePickerWidget(
                looping: false, // default is not looping
                firstDate: DateTime.now(),
                lastDate: DateTime(2026),
                dateFormat: "dd/MMMM/yyyy",
                locale: DatePicker.localeFromString('ar'),
                onChange: (DateTime newDate, _) {
                  selectedDate = newDate;
                },
                pickerTheme: const DateTimePickerTheme(
                  backgroundColor: lightGreen,
                  itemTextStyle: TextStyle(color: Colors.black, fontSize: 19),
                  dividerColor: green,
                ),
              ),
            ),
            BlocBuilder<BookingBloc, BookingState>(
              builder: (context, state) {
                if (state is ShowProviderWorkingHoursState) {
                  availableHours = state.hours;
                  context.read<BookingBloc>().add(RequestUserAddressesEvent());
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
            const TextWidget(
              text: "اختر الموقع",
              textSize: 22,
              textFontWeight: FontWeight.w500,
            ),
            height20,
            BlocBuilder<BookingBloc, BookingState>(
              builder: (context, state) {
                if (state is ShowUserAddressesState) {
                  context
                      .read<BookingBloc>()
                      .add(RequestUserPaymentMethodsEvent());
                  selectedAddresses = state.selectedAddresses;
                  addresses = state.addressesList;
                }

                return ToggleButtons(
                    selectedColor: black,
                    fillColor: coldGreen,
                    splashColor: coldGreen,
                    direction: Axis.vertical,
                    isSelected: selectedAddresses,
                    onPressed: (index5) {
                      context
                          .read<BookingBloc>()
                          .add(SelectAddressEvent(index: index5));
                    },
                    children: List.generate(
                        addresses.length,
                        (index7) => AddressWidget(
                            addi: addresses[index7],
                            state: selectedAddresses[index7])));
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
                            method: paymentMethods[index2])));
              },
            ),
            height20,
            const TextWidget(
              text: "ملاحظة : هذه القيمة لا تشمل قيمة الادوات المطلوبة",
              textSize: 14,
              textColor: red,
            ),
            height20,
            BlocListener<BookingBloc, BookingState>(
              listener: (context, state) {
                if (state is BookingLoadingState) {
                  showLoadingDialog(context: context);
                }
                if (state is BookingErrorState) {
                  snackBarMassage(snackBarText: state.error, context: context);
                }
                if (state is CreatedOrderSuccessfly) {
                  showMessageDialog(context: context, message: 'تم تأكيد طلبك');
                  Future.delayed(const Duration(seconds: 1), () {
                    context.removeUnitl(
                        screen: NavBar(user: state.user, index: 2));
                  });
                }
              },
              child: ContainerWidget(
                  contanierBorderRadius: 10,
                  containerWidth: context.getWidth(),
                  containerHeight: 48,
                  containerColor: green,
                  onPressed: () {
                    context.read<BookingBloc>().add(CreateOrderEvent(
                        selectedAddresses: selectedAddresses,
                        userAddresses: addresses,
                        servicesSelected: selectedServices,
                        hoursSelected: selectedHours,
                        selectedPayments: selectedPayments,
                        userPaymentMethods: paymentMethods,
                        date: selectedDate,
                        provider: providerInfo));
                  },
                  child: const Center(
                      child: TextWidget(
                    text: "تأكيد الحجز",
                    textSize: 25,
                    textColor: lightGrey,
                  ))),
            ),
          ],
        ),
      ),
    );
  }
}
