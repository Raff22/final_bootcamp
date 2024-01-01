import 'package:fazzah_user/models/order_model.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/rating_model.dart';

abstract class OrderEvent {}

class RequestAllUserOrdersEvent extends OrderEvent {}

class RequestAllProviderOrdersEvent extends OrderEvent {}

class RequestOrderRelaitedInfoEvent extends OrderEvent {
  final int paymentMethodID;
  final int addressID;

  RequestOrderRelaitedInfoEvent({
    required this.paymentMethodID,
    required this.addressID,
  });
}

class DeleteOrderEvent extends OrderEvent {
  final int orderId;

  DeleteOrderEvent({required this.orderId});
}

class PayingEvent extends OrderEvent {
  Order order;
  ProviderModel provider;

  PayingEvent({required this.order, required this.provider});
}

class RatingAddingEvent extends OrderEvent {
  final Rating rating;
  final ProviderModel provider;

  RatingAddingEvent({required this.rating, required this.provider});
}
