import 'package:fazzah_user/models/order_model.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/working_hours_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseUpdate {
  final supabase = Supabase.instance.client;

  //-------------- Update Provider Image --------------------
  updateProviderProfileImage(
      {required String providerID, required String providerImage}) async {
    try {
      await supabase
          .from('providers')
          .update({'profile_image': providerImage}).eq('id', providerID);
    } catch (error) {
      print('error in update supabase provider image ${error.toString()}');
    }
  }

  updateProviderAccountInfo(
      {required String providerID,
      String? name,
      String? nationalID,
      String? phoneNumber,
      String? nationality,
      String? job}) async {
    try {
      await supabase.from('providers').update({
        'name': name,
        'phone_number': phoneNumber,
        'id_number': nationalID,
        'job': job,
        'nationality': nationality
      }).eq('id', providerID);
    } catch (error) {
      print('error in update supabase provider info ${error.toString()}');
    }
    return null;
  }

  //---------------- Update new Address -----------------------------
  updateNewAddressUser(
      {required int addresId,
      required String userId,
      required String address,
      required String city,
      required double latitude,
      required double longitude,
      required String addressTitle}) async {
    try {
      await supabase.from('addresses').update({
        'user_id': userId,
        'address': address,
        'city': city,
        'latitude': latitude,
        'longitude': longitude,
        'address_title': addressTitle
      }).eq('id', addresId);
    } catch (error) {
      print("------- error in Supabase function Add new Address User --------");
      print(error);
    }
    return null;
  }

  updateOrder(Order order, ProviderModel provider) async {
    try {
      await supabase.from('orders').update(order.toJson()).eq('id', order.id!);
      await updateProvider(provider);
    } catch (error) {
      print(error.toString());
    }
  }

  updateWorkingHours(WorkingHours workHours) async {
    try {
      await supabase.from('working_hours').upsert(workHours.toJson());
    } catch (error) {
      print(error.toString());
    }
  }

  updateProvider(ProviderModel provider) async {
    try {
      await supabase
          .from('providers')
          .update(provider.toJson())
          .eq('id', provider.id!);
    } catch (error) {
      print(error.toString());
    }
  }

  updateProviderWallet() async {
    final String id = supabase.auth.currentUser!.id;
    try {
      await supabase.from('providers').update({'wallet': 0}).eq('id', id);
    } catch (error) {
      print(error.toString());
    }
  }
}
