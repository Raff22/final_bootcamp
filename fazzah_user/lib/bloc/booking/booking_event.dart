part of 'booking_bloc.dart';

abstract class BookingEvent {}

class RequestProvidersEvent extends BookingEvent {}

class RequestProviderRatingsEvent extends BookingEvent {
  final String providerId;

  RequestProviderRatingsEvent({required this.providerId});
}

class RequestUserPaymentMethodsEvent extends BookingEvent {}

class RequestUserAddressesEvent extends BookingEvent {}

class RequestProvidersByNameEvent extends BookingEvent {
  final String name;

  RequestProvidersByNameEvent({required this.name});
}

class RequestProvidersByServiceEvent extends BookingEvent {
  final String service;

  RequestProvidersByServiceEvent({required this.service});
}

class SelectedServiceEvent extends BookingEvent {
  final int index;

  SelectedServiceEvent({required this.index});
}

class SelectedHourEvent extends BookingEvent {
  final int index;

  SelectedHourEvent({required this.index});
}

class SelectPaymentMethodEvent extends BookingEvent {
  final int index;

  SelectPaymentMethodEvent({required this.index});
}

class SelectAddressEvent extends BookingEvent {
  final int index;

  SelectAddressEvent({required this.index});
}

class GetProviderHoursEvent extends BookingEvent {
  final String providerId;

  GetProviderHoursEvent({required this.providerId});
}

class CreateOrderEvent extends BookingEvent {
  final List<bool> servicesSelected;
  final List<bool> hoursSelected;
  final List<bool> selectedPayments;
  final List<PaymentMethod> userPaymentMethods;
  final List<bool> selectedAddresses;
  final List<Address> userAddresses;
  final DateTime date;
  final ProviderModel provider;

  CreateOrderEvent(
      {required this.servicesSelected,
      required this.hoursSelected,
      required this.selectedPayments,
      required this.userPaymentMethods,
      required this.selectedAddresses,
      required this.userAddresses,
      required this.date,
      required this.provider});
}
