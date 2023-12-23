import 'package:fazzah_user/views/user_main_views/blocks/fav_bloc/fav_event.dart';
import 'package:fazzah_user/views/user_main_views/blocks/fav_bloc/fav_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavBloc extends Bloc<FavEvent, FavState> {
  bool currentfav = false;
  FavBloc() : super(FavInitial()) {
    on<FavToggleEvent>(
      (event, emit) {
        if (currentfav == false) {
          currentfav = true;
          emit(FavSelected(isFav: currentfav));
        } else {
          currentfav = false;
          emit(FavSelected(isFav: currentfav));
        }
      },
    );
  }
}
