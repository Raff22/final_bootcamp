import 'package:fazzah_user/models/address.dart';
import 'package:fazzah_user/models/order_model.dart';
import 'package:fazzah_user/models/payment_method.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/rating_model.dart';
import 'package:fazzah_user/models/user_model.dart';
import 'package:fazzah_user/models/working_hours_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupaGetAndDelete {
  final supabase = Supabase.instance.client;

  getProvider(String id) async {
    try {
      final response = await supabase.from('providers').select().eq('id', id);
      if (response.isEmpty) {
        return null;
      } else {
        ProviderModel temp = ProviderModel.fromJson(response[0]);
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

  getAllProvidersFavs() async {
    Map<ProviderModel, bool> temp = {};
    try {
      final response = await supabase.from('providers').select();
      if (response.isEmpty) {
        return temp;
      } else {
        final List<ProviderModel> providers = List.generate(response.length,
            (index) => ProviderModel.fromJson(response[index]));
        final List<ProviderModel> favs = await getFavoriteProviders();
        for (ProviderModel element in providers) {
          if (favs.any((element2) => element.id == element2.id)) {
            temp[element] = true;
          } else {
            temp[element] = false;
          }
        }
        return temp;
      }
    } catch (error) {
      print(error.toString());
      return temp;
    }
  }

  getProvidersByName(String name) async {
    Map<ProviderModel, bool> temp = {};
    try {
      final response =
          await supabase.from('providers').select().eq('name', name);
      if (response.isEmpty) {
        return temp;
      } else {
        final List<ProviderModel> providers = List.generate(response.length,
            (index) => ProviderModel.fromJson(response[index]));
        final List<ProviderModel> favs = await getFavoriteProviders();
        for (ProviderModel element in providers) {
          if (favs.any((element2) => element.id == element2.id)) {
            temp[element] = true;
          } else {
            temp[element] = false;
          }
        }
        return temp;
      }
    } catch (error) {
      print(error.toString());
      return temp;
    }
  }

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

  getOrderProviders() async {
    String id = supabase.auth.currentUser!.id;
    try {
      final response = await supabase.from('orders').select().eq("user", id);
      print(response);
      if (response.isEmpty) {
        return null;
      } else {
        Order temp = Order.fromJson(response[0]);

        return temp;
      }
    } catch (error) {
      print(error.toString());
      List<ProviderModel> temp2 = [];
      return temp2;
    }
  }

  getProvidersByService(String job) async {
    Map<ProviderModel, bool> temp = {};
    try {
      final response =
          await supabase.from('providers').select().textSearch('services', job);
      if (response.isEmpty) {
        return temp;
      } else {
        final List<ProviderModel> providers = List.generate(response.length,
            (index) => ProviderModel.fromJson(response[index]));
        final List<ProviderModel> favs = await getFavoriteProviders();
        for (ProviderModel element in providers) {
          if (favs.any((element2) => element.id == element2.id)) {
            temp[element] = true;
          } else {
            temp[element] = false;
          }
        }
        return temp;
      }
    } catch (error) {
      print(error.toString());
      return temp;
    }
  }

  getDoneOrders() async {
    final String id = supabase.auth.currentUser!.id;
    Map<Order, ProviderModel> data = {};
    try {
      final response = await supabase.from('orders').select().eq('user', id);
      if (response.isEmpty) {
        return data;
      } else {
        for (var map in response) {
          if (map['is_done']) {
            final Order order = Order.fromJson(map);
            final ProviderModel temp = await getProvider(map['provider']);
            data[order] = temp;
          }
        }
        return data;
      }
    } catch (error) {
      print(error.toString());
      return data;
    }
  }

  getNotDoneOrders() async {
    final String id = supabase.auth.currentUser!.id;
    Map<Order, ProviderModel> data = {};
    try {
      final response = await supabase.from('orders').select().eq('user', id);
      if (response.isEmpty) {
        return data;
      } else {
        for (var map in response) {
          if (map['is_done'] == false) {
            final Order order = Order.fromJson(map);
            final ProviderModel temp = await getProvider(map['provider']);
            data[order] = temp;
          }
        }
        return data;
      }
    } catch (error) {
      print(error.toString());
      return data;
    }
  }

  getDoneOrdersProvider() async {
    final String id = supabase.auth.currentUser!.id;
    Map<Order, UserModel> data = {};
    try {
      final response =
          await supabase.from('orders').select().eq('provider', id);
      if (response.isEmpty) {
        return data;
      } else {
        print("getDoneOrdersProvider else");
        for (var map in response) {
          if (map['is_done']) {
            final Order order = Order.fromJson(map);
            final UserModel temp = await getUser(userId: map['user']);
            print(temp.id);
            data[order] = temp;
          }
        }
        return data;
      }
    } catch (error) {
      print(error.toString());
      return data;
    }
  }

  getNotDoneOrdersProvider() async {
    final String id = supabase.auth.currentUser!.id;
    Map<Order, UserModel> data = {};
    try {
      final response =
          await supabase.from('orders').select().eq('provider', id);
      if (response.isEmpty) {
        return data;
      } else {
        for (var map in response) {
          if (map['is_done'] == false) {
            final Order order = Order.fromJson(map);
            final UserModel temp = await getUser(userId: map['user']);
            data[order] = temp;
          }
        }
        return data;
      }
    } catch (error) {
      print(error.toString());
      return data;
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
          final ProviderModel temp = await getProvider(map['provider_id']);
          favs.add(temp);
        }
        return favs;
      }
    } catch (error) {
      print(error.toString());
      return favs;
    }
  }

  getUserAddresses() async {
    final String id = supabase.auth.currentUser!.id;
    List<Address> temp = [];
    try {
      final response =
          await supabase.from('addresses').select().eq('user_id', id);
      if (response.isEmpty) {
        return temp;
      } else {
        return List.generate(
            response.length, (index) => Address.fromJson(response[index]));
      }
    } catch (error) {
      print(error.toString());
      return temp;
    }
  }

  getAddressesById({required int id}) async {
    try {
      final response = await supabase.from('addresses').select().eq('id', id);
      if (response.isEmpty) {
        return null;
      } else {
        return Address.fromJson(response[0]);
      }
    } catch (error) {
      print(error.toString());
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
    try {
      final response =
          await supabase.from('payment_methods').select().eq('user_id', id);
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

  getPaymentMethodById({required int id}) async {
    try {
      final response =
          await supabase.from('payment_methods').select().eq('id', id);
      if (response.isEmpty) {
        return null;
      } else {
        return PaymentMethod.fromJson(response[0]);
      }
    } catch (error) {
      print(error.toString());
    }
  }

  //----------------- get User ------------------------
  getUser({required String userId}) async {
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

  getCurrentUser() async {
    final String id = supabase.auth.currentUser!.id;
    try {
      final response = await supabase.from('users').select().eq('id', id);
      return UserModel.fromJson(response[0]);
    } catch (error) {
      print(error);
    }
  }

  getAllusers() async {
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

  //---------------- get All Address by User ID -----------------------------
  Future<Address?> getAllAddressbyUserID({required String userId}) async {
    try {
      final response = await supabase
          .from('addresses')
          .select()
          .eq('user_id', '8bc48f85-ab08-4d48-8c17-310a602ea808');
      print(response[0]);

      if (response.isEmpty) {
        return null;
      } else {
        return Address.fromJson(response[0]);
      }
    } catch (error) {
      print("------- error in Supabase function getAddress --------");
      print(error);
    }
    return null;
  }
}
