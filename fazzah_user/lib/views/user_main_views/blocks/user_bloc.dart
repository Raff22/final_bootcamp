import 'package:fazzah_user/database/delete_data.dart';
import 'package:fazzah_user/database/get_data.dart';
import 'package:fazzah_user/database/supabase_add.dart';
import 'package:fazzah_user/database/update_data.dart';
import 'package:fazzah_user/models/address.dart';
import 'package:fazzah_user/views/user_main_views/blocks/user_event.dart';
import 'package:fazzah_user/views/user_main_views/blocks/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(InitialUserState()) {
    // ----------- add new address ---------------
    on<AddNewAddress>((event, emit) async {
      try {
        if (event.addressId == null) {
          await SupaAdd().addNewAddressUser(
              userId: event.userId!,
              address: event.address!,
              city: event.city!,
              latitude: event.latitude!,
              longitude: event.longitude!,
              addressTitle: event.addressTitle!);
        } else {
          await SupabaseUpdate().updateNewAddressUser(
              addresId: event.addressId!,
              userId: event.userId!,
              address: event.address!,
              city: event.city!,
              latitude: event.latitude!,
              longitude: event.longitude!,
              addressTitle: event.addressTitle!);
        }
      } catch (error) {
        print('--------- Error in add address user bloc ---------');
        print(error);
      }
    });

    // ----------- display all user addresses ---------------
    on<GetAllUserAddressEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final List<Address> addressList = await getAddress();
        emit(AllUserAddressState(addressList));
      } catch (error) {
        print(error);
        emit(ErrorState(error.toString()));
      }
    });

    // ----------- dlete user addresses ---------------
    on<DeleteUserAddressEvent>((event, emit) async {
      try {
        await SupabaseDelete().deleteUserAddress(addressId: event.addressID);
        emit(UpdateState());
      } catch (error) {
        print(error);
        emit(ErrorState(error.toString()));
      }
    });
  }
}

Future<List<Address>> getAddress() async {
  final List<Address> addressList = await SupaGet().getUserAddresses();
  return addressList;
}
