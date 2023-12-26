part of 'booking_bloc.dart';

abstract class BookingEvent {}

class RequestProvidersEvent extends BookingEvent {}

class RequestProviderRatingsEvent extends BookingEvent {
  final String providerId;

  RequestProviderRatingsEvent({required this.providerId});
}

class SelectedServiceEvent extends BookingEvent {
  final int index;

  SelectedServiceEvent({required this.index});
}

class GetProviderHoursEvent extends BookingEvent {
  final String providerId;

  GetProviderHoursEvent({required this.providerId});
}
