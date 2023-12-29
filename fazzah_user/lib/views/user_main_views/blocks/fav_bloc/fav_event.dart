abstract class FavEvent {}

class FavToggleEvent extends FavEvent {
  final bool state;
  final String providerID;

  FavToggleEvent({required this.state, required this.providerID});

}

class RequestFavList extends FavEvent {}
