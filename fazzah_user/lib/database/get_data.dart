import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/rating_model.dart';
import 'package:fazzah_user/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupaGetAndDelete {
  final supabase = Supabase.instance.client;

  getProvider(String id) async {
    print("got here in getprovider");
    print("id $id");
    try {
      final response = await supabase.from('providers').select().eq('id', id);
      print(response);
      if (response.isEmpty) {
        return null;
      } else {
        print("else in getProvider");
        ProviderModel temp = ProviderModel.fromJson(response[0]);
        print(temp.name);
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

  getProviderRatings({required String providerId}) async {
    try {
      final response =
          await supabase.from('ratings').select().eq('provider', providerId);
      print(response);
      if (response.isEmpty) {
        return [];
      } else {
        return List.generate(
            response.length, (index) => Rating.fromJson(response[index]));
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
}
