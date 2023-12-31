import 'package:fazzah_user/models/payment_method.dart';

abstract class PayState {}

class PayInitial extends PayState {}

class ShowAllPaymentsState extends PayState {
  final List<PaymentMethod> isdonelist;

  ShowAllPaymentsState({required this.isdonelist});
}

class ShowAllPaymentsPayState extends PayState {
  final List<PaymentMethod> cardslist;

  ShowAllPaymentsPayState({required this.cardslist});
}

class PayErrorState extends PayState {
  final String error;

  PayErrorState({required this.error});
}

class PayLoadingState extends PayState {}

class ShowSelectedServiceState extends PayState {
  final List<bool> newSelected;

  ShowSelectedServiceState({required this.newSelected});
}

class ShowSelectedHourState extends PayState {
  final List<bool> newSelected;

  ShowSelectedHourState({required this.newSelected});
}
