import 'package:fazzah_user/models/provider_model.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class ShowAllProvidersState extends OrderState {
  final List<ProviderModel> isdonelist;
  final List<ProviderModel> notdonelist;

  ShowAllProvidersState({required this.isdonelist, required this.notdonelist});
}

class ShowAllProvidersOrderState extends OrderState {
  final List<ProviderModel> providersList;

  ShowAllProvidersOrderState({required this.providersList});
}

class OrderErrorState extends OrderState {
  final String error;

  OrderErrorState({required this.error});
}

class OrderLoadingState extends OrderState {}

class ShowSelectedServiceState extends OrderState {
  final List<bool> newSelected;

  ShowSelectedServiceState({required this.newSelected});
}

class ShowSelectedHourState extends OrderState {
  final List<bool> newSelected;

  ShowSelectedHourState({required this.newSelected});
}
