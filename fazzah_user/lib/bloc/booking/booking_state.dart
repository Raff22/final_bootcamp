part of 'booking_bloc.dart';

abstract class BookingState {}

class BookingInitial extends BookingState {}

class ShowAllProvidersState extends BookingState {
  final List<ProviderModel> providersList;

  ShowAllProvidersState({required this.providersList});
}

class BookingErrorState extends BookingState {
  final String error;

  BookingErrorState({required this.error});
}

class BookingLoadingState extends BookingState {}
