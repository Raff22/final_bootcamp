import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseUpdate {
  final supabase = Supabase.instance.client;

  updateProviderProfileImage(
      {required String providerID, required String providerImage}) async {
    try {
      await supabase
          .from('providers')
          .update({'profile_image': providerImage}).eq('id', providerID);
    } catch (error) {
      print('error in update supabase provider image ${error.toString()}');
    }
  }
}
