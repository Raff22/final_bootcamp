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
