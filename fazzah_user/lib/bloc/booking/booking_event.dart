part of 'booking_bloc.dart';

abstract class BookingEvent {}

class RequestProvidersEvent extends BookingEvent {}

class RequestProviderRatingsEvent extends BookingEvent {
  final String providerId;

  RequestProviderRatingsEvent({required this.providerId});
}

class RequestUserPaymentMethodsEvent extends BookingEvent {}

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

class GetProviderHoursEvent extends BookingEvent {
  final String providerId;

  GetProviderHoursEvent({required this.providerId});
}
