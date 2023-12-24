abstract class FavState {}

class FavInitial extends FavState {}

class FavSelected extends FavState {
  final bool isFav;
  FavSelected({required this.isFav});
}
