import 'package:fazzah_user/models/provider_model.dart';

abstract class FavState {}

class FavInitial extends FavState {}

class FavSelected extends FavState {
  final bool isFav;
  final String id;

  FavSelected({required this.isFav, required this.id});
}

class ShowFavoritesState extends FavState {
  final List<ProviderModel> favList;

  ShowFavoritesState({required this.favList});
}

class FavoriteLoadingState extends FavState {}

class FavoriteErrorState extends FavState {
  final String error;

  FavoriteErrorState({required this.error});
}
