part of 'booking_bloc.dart';

abstract class BookingState {}

class BookingInitial extends BookingState {}

class ShowAllProvidersState extends BookingState {
  final List<ProviderModel> providers;
  final List<bool> favs;

  ShowAllProvidersState({required this.providers, required this.favs});
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

class ShowUserPaymentMethodsState extends BookingState {
  final List<PaymentMethod> paymentMethodsList;
  final List<bool> selectedPayments;

  ShowUserPaymentMethodsState(
      {required this.paymentMethodsList, required this.selectedPayments});
}

class ShowUserAddressesState extends BookingState {
  final List<Address> addressesList;
  final List<bool> selectedAddresses;

  ShowUserAddressesState(
      {required this.addressesList, required this.selectedAddresses});
}

class ShowSelectedHourState extends BookingState {
  final List<bool> newSelected;

  ShowSelectedHourState({required this.newSelected});
}

class ShowProviderWorkingHoursState extends BookingState {
  final WorkingHours hours;

  ShowProviderWorkingHoursState({required this.hours});
}

class CreatedOrderSuccessfly extends BookingState {
  final UserModel user;

  CreatedOrderSuccessfly({required this.user});
}
