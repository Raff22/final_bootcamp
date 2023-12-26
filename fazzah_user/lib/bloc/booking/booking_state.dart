part of 'booking_bloc.dart';

abstract class BookingState {}

class BookingInitial extends BookingState {}

class ShowAllProvidersState extends BookingState {
  final List<ProviderModel> providersList;

  ShowAllProvidersState({required this.providersList});
}

class ShowProviderRatingsState extends BookingState {
  final List<Rating> ratings;

  ShowProviderRatingsState({required this.ratings});
}

class BookingErrorState extends BookingState {
  final String error;

  BookingErrorState({required this.error});
}

class BookingLoadingState extends BookingState {}

class ShowSelectedServiceState extends BookingState {
  final List<bool> newSelected;

  ShowSelectedServiceState({required this.newSelected});
}

class ShowSelectedHourState extends BookingState {
  final List<bool> newSelected;

  ShowSelectedHourState({required this.newSelected});
}

class ShowProviderWorkingHoursState extends BookingState {
  final WorkingHours hours;

  ShowProviderWorkingHoursState({required this.hours});
}
