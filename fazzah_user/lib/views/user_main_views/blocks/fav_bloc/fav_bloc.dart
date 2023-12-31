import 'package:fazzah_user/database/delete_data.dart';
import 'package:fazzah_user/database/get_data.dart';
import 'package:fazzah_user/database/supabase_add.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/views/user_main_views/blocks/fav_bloc/fav_event.dart';
import 'package:fazzah_user/views/user_main_views/blocks/fav_bloc/fav_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavBloc extends Bloc<FavEvent, FavState> {
  FavBloc() : super(FavInitial()) {
    on<FavToggleEvent>(
      (event, emit) async {
        bool currentfav = event.state;
        if (currentfav == false) {
          currentfav = true;
          emit(FavSelected(isFav: currentfav, id: event.providerID));
          await SupaAdd().addFavorite(event.providerID);
          add(RequestFavList());
        } else {
          currentfav = false;
          emit(FavSelected(isFav: currentfav, id: event.providerID));
          await SupabaseDelete().deleteFavorite(event.providerID);
          add(RequestFavList());
        }
      },
    );
    on<RequestFavList>((event, emit) async {
      emit(FavoriteLoadingState());
      try {
        final List<ProviderModel> favs = await SupaGet().getFavoriteProviders();
        emit(ShowFavoritesState(favList: favs));
      } catch (error) {
        print(error.toString());
        emit(FavoriteErrorState(error: "حصل خطأ في النظام"));
      }
    });
  }
}
