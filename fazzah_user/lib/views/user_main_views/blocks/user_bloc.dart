import 'package:fazzah_user/database/supabase_add.dart';
import 'package:fazzah_user/views/user_main_views/blocks/user_event.dart';
import 'package:fazzah_user/views/user_main_views/blocks/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(InitialUserState()) {
    // ----------- add new address ---------------
    on<AddNewAddress>((event, emit) async {
      try {
        await SupaAdd().addNewAddressUser(
            userId: event.userId!,
            address: event.address!,
            city: event.city!,
            latitude: event.latitude!,
            longitude: event.longitude!,
            addressTitle: event.addressTitle!);
        print('has been added to database');
      } catch (error) {
        print('--------- Error in add address user bloc ---------');
        print(error);
      }
    });
  }
}
