import 'dart:io';
import 'package:fazzah_user/database/update_data.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupaStorage {
  final supabase = Supabase.instance.client.storage;

  // ----------------- Upload Provider Image -----------------------
  uploadProviderImage(
      {required File file, required ProviderModel providerModel}) async {
    final fileBytes = await file.readAsBytes();
    final path =
        "profile_images/${providerModel.id}${DateTime.now()}profileimage.png";

    try {
      await supabase.from('Fazzah_storage').uploadBinary(path, fileBytes);
      final response = supabase.from('Fazzah_storage').getPublicUrl(path);
      final url = response;
      await SupabaseUpdate().updateProviderProfileImage(
          providerID: providerModel.id!, providerImage: url);
      return url;
    } catch (error) {
      print('upload provider image Error${error.toString()}');
    }
  }

  // ----------------- Update Provider Image -----------------------
  updateProviderImage(
      {required File file,
      required ProviderModel providerModel,
      required String path}) async {
    try {
      await deleteProviderImage(providerModel: providerModel);
      return await uploadProviderImage(
          file: file, providerModel: providerModel);
    } catch (error) {
      print('update provider image Error : ${error.toString()}');
    }
  }

  // ----------------- Delete Provider Image -----------------------
  deleteProviderImage({required ProviderModel providerModel}) async {
    try {
      final allList =
          await supabase.from('Fazzah_storage').list(path: 'profile_images');
      for (var element in allList) {
        if (element.name.startsWith(providerModel.id!)) {
          await supabase
              .from('Fazzah_storage')
              .remove(["profile_images/${element.name}"]);
        }
      }
      providerModel.providerImage = null;
      await SupabaseUpdate().updateProvider(providerModel);
    } catch (error) {
      print('delete peovider image Error : ${error.toString()}');
    }
  }
}
