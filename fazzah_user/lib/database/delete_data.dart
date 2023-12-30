import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDelete {
  final supabase = Supabase.instance.client;

  //---------------- Delete user Address -----------------------------
  deleteUserAddress({
    required int addressId,
  }) async {
    try {
      await supabase.from('addresses').delete().eq('id', addressId);
      print('address has been deleted');
    } catch (error) {
      print("------- error in Supabase function Add new Address User --------");
      print(error);
    }
    return null;
  }
  // ---------------------------------------------------------------------------
}
