part of 'booking_bloc.dart';

abstract class BookingEvent {}

class RequestProvidersEvent extends BookingEvent {}

class RequestProviderRatingsEvent extends BookingEvent {
  final String providerId;

  RequestProviderRatingsEvent({required this.providerId});
}
