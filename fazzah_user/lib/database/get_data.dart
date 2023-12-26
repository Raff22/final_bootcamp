import 'package:fazzah_user/models/provider_model.dart';
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
    print("got here in getprovider");
    print("id");
    try {
      final response = await supabase.from('providers').select();
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

  getUser({required String userId}) {}
}
