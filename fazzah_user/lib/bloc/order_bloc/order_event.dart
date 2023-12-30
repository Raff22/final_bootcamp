abstract class OrderEvent {}

class RequestallProvidersEvent extends OrderEvent {}

class RequestProviderRatingsEvent extends OrderEvent {
  final String providerId;

  RequestProviderRatingsEvent({required this.providerId});
}

class RequestProvidersByidEvent extends OrderEvent {
  final String id;

  RequestProvidersByidEvent({required this.id});
}

class RequestProvidersByServiceEvent extends OrderEvent {
  final String service;

  RequestProvidersByServiceEvent({required this.service});
}

class SelectedServiceEvent extends OrderEvent {
  final int index;

  SelectedServiceEvent({required this.index});
}

class SelectedHourEvent extends OrderEvent {
  final int index;

  SelectedHourEvent({required this.index});
}

class GetProviderHoursEvent extends OrderEvent {
  final String providerId;

  GetProviderHoursEvent({required this.providerId});
}
