import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDelete {
  final supabase = Supabase.instance.client;

  //---------------- Delete user Address -----------------------------
  deleteUserAddress({
    required int addressId,
  }) async {
    try {
      await supabase.from('addresses').delete().eq('id', 12);
      print('address has been deleted');
    } catch (error) {
      print("------- error in Supabase function Delete user Address --------");
      print(error);
    }
    return null;
  }
  // ---------------------------------------------------------------------------

  deleteFavorite(String providerId) async {
    final String id = supabase.auth.currentUser!.id;
    try {
      await supabase
          .from('favorites')
          .delete()
          .eq('user_id', id)
          .eq('provider_id', providerId);
    } catch (error) {
      print(error.toString());
    }
  }

  deleteOrder(int orderId) async {
    try {
      await supabase.from('orders').delete().eq('id', orderId);
    } catch (error) {
      print(error.toString());
    }
  }
}
