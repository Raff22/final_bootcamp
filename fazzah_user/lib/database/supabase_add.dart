import 'package:fazzah_user/models/order_model.dart';
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
}
