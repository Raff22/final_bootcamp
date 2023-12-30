import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseInsetr {
  final supabase = Supabase.instance.client;

  //---------------- Add new Address -----------------------------
  addNewAddressUser(
      {required String userId,
      required String address,
      required String city,
      required double latitude,
      required double longitude,
      required String addressTitle}) async {
    try {
      await supabase.from('addresses').insert({
        'user_id': userId,
        'address': address,
        'city': city,
        'latitude': latitude,
        'longitude': longitude,
        'address_title': addressTitle
      });
    } catch (error) {
      print("------- error in Supabase function Add new Address User --------");
      print(error);
    }
    return null;
  }
  // ---------------------------------------------------------------------------
}
