import 'package:fazzah_user/database/get_data.dart';
import 'package:fazzah_user/models/order_model.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupaAdd {
  final supabase = Supabase.instance.client;

  Future<Order?> addNewOrder(Order order) async {
    final String id = supabase.auth.currentUser!.id;
    order.user = id;
    try {
      final response =
          await supabase.from('orders').insert(order.toJson()).select();
      return Order.fromJson(response[0]);
    } catch (error) {
      print(error.toString());
    }
    return null;
  }

  addFavorite(String providerId) async {
    final String id = supabase.auth.currentUser!.id;
    bool add = true;
    try {
      final response = await SupaGetAndDelete().getFavoriteProviders();
      for (ProviderModel element in response) {
        if (element.id == providerId) {
          add = false;
          break;
        }
      }
      if (add) {
        await supabase
            .from('favorites')
            .insert({'user_id': id, 'provider_id': providerId});
      }
    } catch (error) {
      print(error.toString());
    }
  }
}
