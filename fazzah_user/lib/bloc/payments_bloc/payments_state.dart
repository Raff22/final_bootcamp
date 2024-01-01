import 'package:fazzah_user/models/payment_method.dart';

abstract class PayState {}

class PayInitial extends PayState {}

class ShowAllPaymentsState extends PayState {
  final List<PaymentMethod> isdonelist;

  ShowAllPaymentsState({required this.isdonelist});
}

class PayErrorState extends PayState {
  final String error;

  PayErrorState({required this.error});
}

class PayLoadingState extends PayState {}
