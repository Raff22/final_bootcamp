import 'package:fazzah_user/models/address.dart';
import 'package:fazzah_user/models/order_model.dart';
import 'package:fazzah_user/models/payment_method.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/user_model.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class ShowUserOrdersState extends OrderState {
  final Map<Order, ProviderModel> isDoneMap;
  final Map<Order, ProviderModel> notDoneMap;

  ShowUserOrdersState({required this.isDoneMap, required this.notDoneMap});
}

class ShowProviderOrdersState extends OrderState {
  final Map<Order, UserModel> isDoneMap;
  final Map<Order, UserModel> notDoneMap;

  ShowProviderOrdersState({required this.isDoneMap, required this.notDoneMap});
}

class OrderErrorState extends OrderState {
  final String error;

  OrderErrorState({required this.error});
}

class OrderLoadingState extends OrderState {}

class ShowOrderRelatiedInfo extends OrderState {
  final Address address;
  final PaymentMethod paymentMethod;

  ShowOrderRelatiedInfo({required this.address, required this.paymentMethod});
}

class DeletedOrderSuccessfully extends OrderState {
  final UserModel user;

  DeletedOrderSuccessfully({required this.user});
}

class PaymentCompletedSuccessfully extends OrderState {
  final UserModel user;

  PaymentCompletedSuccessfully({required this.user});
}

class RatingAddedSuccessfully extends OrderState {}
