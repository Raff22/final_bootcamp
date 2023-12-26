import 'package:fazzah_user/app_data/static_data.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/rating_model.dart';
import 'package:fazzah_user/models/user_model.dart';
import 'package:fazzah_user/models/working_hours_model.dart';
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

  getProvidersByService(String job) async {
    print(job);
    try {
      final response =
          await supabase.from('providers').select().textSearch('services', job);
      print(response);
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
