import 'package:fazzah_user/app_data/static_data.dart';
import 'package:fazzah_user/models/order_model.dart';
import 'package:fazzah_user/models/payment_method.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/rating_model.dart';
import 'package:fazzah_user/models/user_model.dart';
import 'package:fazzah_user/models/working_hours_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupaGetAndDelete {
  final supabase = Supabase.instance.client;

  Future<ProviderModel?> getProvider(String id) async {
    // print("got here in getprovider");
    // print("id $id");
    try {
      final response = await supabase.from('providers').select().eq('id', id);
      // print(response);
      if (response.isEmpty) {
        return null;
      } else {
        // print("else in getProvider");
        ProviderModel temp = ProviderModel.fromJson(response[0]);
        // print(temp.name);
        return temp;
      }
    } catch (error) {
      print(error.toString());
    }
  }

  getAllProviders() async {
    print(3);
    try {
      final response = await supabase.from('providers').select();
      if (response.isEmpty) {
        final List<ProviderModel> temp = [];
        return temp;
      } else {
        return List.generate(response.length,
            (index) => ProviderModel.fromJson(response[index]));
      }
    } catch (error) {
      print(error.toString());
    }
  }

  getProvidersByName(String name) async {
    try {
      final response =
          await supabase.from('providers').select().eq('name', name);
      if (response.isEmpty) {
        final List<ProviderModel> temp = [];
        return temp;
      } else {
        return List.generate(response.length,
            (index) => ProviderModel.fromJson(response[index]));
      }
    } catch (error) {
      print(error.toString());
    }
  }

  getOrderProviders() async {
    String id = supabase.auth.currentUser!.id;
    print("got here in order here!");
    print("id  $id");
    try {
      final response = await supabase.from('orders').select().eq("user", id);
      print(response);
      if (response.isEmpty) {
        return null;
      } else {
        print("else in getProvider");
        Order temp = Order.fromJson(response[0]);
        print(temp.provider);
        return temp;
      }
    } catch (error) {
      print(error.toString());
      List<ProviderModel> temp2 = [];
      return temp2;
    }
  }

  Future<List<ProviderModel>> getOrderDone() async {
    String id = supabase.auth.currentUser!.id;
    try {
      final response = await supabase.from('orders').select().eq("user", id);
      List<ProviderModel> temp = [];
      if (response.isEmpty) {
        return temp;
      } else {
        for (var e in response) {
          print(e);

          if (e['is_done'] == true) {
            print("object");
            ProviderModel? p = await getProvider(e['provider']);
            if (p != null) {
              temp.add(p);
            }
          }
        }
        return temp;
      }
    } catch (error) {
      print(error.toString());
      List<ProviderModel> temp2 = [];
      return temp2;
    }
  }

  Future<List<ProviderModel>> getOrderNotDone() async {
    String id = supabase.auth.currentUser!.id;
    try {
      final response = await supabase.from('orders').select().eq("user", id);
      List<ProviderModel> temp = [];
      if (response.isEmpty) {
        return temp;
      } else {
        for (var e in response) {
          print(e);

          if (e['is_done'] == false) {
            print("object");
            ProviderModel? p = await getProvider(e['provider']);
            if (p != null) {
              temp.add(p);
            }
          }
        }
        return temp;
      }
    } catch (error) {
      print(error.toString());
      return [];
    }
  }

  getProvidersByService(String job) async {
    print(job);
    try {
      final response =
          await supabase.from('providers').select().textSearch('services', job);
      print(response);
      if (response.isEmpty) {
        return [];
      } else {
        return List.generate(response.length,
            (index) => ProviderModel.fromJson(response[index]));
      }
    } catch (error) {
      print(error.toString());
    }
  }

  getFavoriteProviders() async {
    final String id = supabase.auth.currentUser!.id;
    List<ProviderModel> favs = [];
    try {
      final response =
          await supabase.from('favorites').select().eq('user_id', id);
      if (response.isEmpty) {
        return favs;
      } else {
        for (Map map in response) {
          final ProviderModel? temp = await getProvider(map['provider_id']);
          favs.add(temp!);
        }
        return favs;
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<List<ProviderModel>> getOrderedProviders() async {
    final String id = supabase.auth.currentUser!.id;
    List<ProviderModel> order = [];
    try {
      final response = await supabase.from('orders').select().eq('user', id);
      if (response.isEmpty) {
        return order;
      } else {
        for (Map map in response) {
          final ProviderModel? temp = await getProvider(map['provider']);
          order.add(temp!);
        }
        return order;

        //return List.generate(
        // order.length, (index) => ProviderModel.fromJson(response[index]));
      }
    } catch (error) {
      print(
          "------------------------${error.toString()}----------------------------");
      throw FormatException("error");
    }
  }

  getProviderRatings({required String providerId}) async {
    try {
      final response =
          await supabase.from('ratings').select().eq('provider', providerId);
      if (response.isEmpty) {
        final List<Rating> temp = [];
        return temp;
      } else {
        return List.generate(
            response.length, (index) => Rating.fromJson(response[index]));
      }
    } catch (error) {
      print(error.toString());
    }
  }

  getProviderWorkingHours({required String providerId}) async {
    try {
      final response =
          await supabase.from('working_hours').select().eq('id', providerId);
      // print(response);
      if (response.isNotEmpty) {
        return WorkingHours.fromJson(response[0]);
      } else {
        return (WorkingHours());
      }
    } catch (error) {
      print(error.toString());
    }
  }

  getUserPaymentMethods() async {
    String id = supabase.auth.currentUser!.id;
    print(id);
    try {
      final response =
          await supabase.from('payment_methods').select().eq('user_id', id);
      print(response);
      if (response.isEmpty) {
        final List<PaymentMethod> temp = [];
        return temp;
      } else {
        return List.generate(response.length,
            (index) => PaymentMethod.fromJson(response[index]));
      }
    } catch (error) {
      print(error.toString());
    }
  }

  //----------------- get User ------------------------
  Future<UserModel?> getUser({required String userId}) async {
    try {
      final response = await supabase.from('users').select().eq('id', userId);
      if (response.isEmpty) {
        return null;
      } else {
        return UserModel.fromJson(response[0]);
      }
    } catch (error) {
      print("------- error in Supabase function getUser --------");
      print(error);
    }
    return null;
  }

  getAllusers() async {
    print(3);
    try {
      final response = await supabase.from('users').select();
      print(response);
      if (response.isEmpty) {
        return [];
      } else {
        return List.generate(
            response.length, (index) => UserModel.fromJson(response[index]));
      }
    } catch (error) {
      print(error.toString());
    }
  }

  //---------------- get Provider -----------------------------
  Future<ProviderModel?> getProviderRahaf({required String userId}) async {
    try {
      final response =
          await supabase.from('providers').select().eq('id', userId);

      if (response.isEmpty) {
        return null;
      } else {
        return ProviderModel.fromJson(response[0]);
      }
    } catch (error) {
      print("------- error in Supabase function getUser --------");
      print(error);
    }
    return null;
  }

  Future<void> addPaymentMethodToSupabase(PaymentMethod paymentMethod) async {
    final response =
        await supabase.from('payment_methods').insert(paymentMethod.toJson());

    if (response.error != null) {
      // Handle the error, maybe show an alert to the user
      print('Error when inserting: ${response.error?.message}');
    } else {
      // If no error, maybe show a success message
      print('Inserted successfully: ${response.data}');
    }
  }
}
