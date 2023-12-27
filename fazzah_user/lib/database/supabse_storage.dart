import 'dart:io';

import 'package:fazzah_user/database/get_data.dart';
import 'package:fazzah_user/database/update_data.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupaStorage {
  final supabase = Supabase.instance.client.storage;

  // -----------------------------------------
  uploadProviderImage(
      {required File file, required ProviderModel providerModel}) async {
    final fileBytes = await file.readAsBytes();
    final path =
        "profile_images/${providerModel.id}${DateTime.now()}profileimage.png";

    try {
      await supabase.from('Fazzah_storage').uploadBinary(path, fileBytes);
      final response = supabase.from('Fazzah_storage').getPublicUrl(path);
      final url = response;
      print('the url for image provider');
      print(url);
      await SupabaseUpdate().updateProviderProfileImage(
          providerID: providerModel.id!, providerImage: url);
      return url;
    } catch (error) {
      print('upload provider image Error${error.toString()}');
    }
  }

  // -----------------------------------------
  updateProviderImage(
      {required File file,
      required ProviderModel providerModel,
      required String path}) async {
    try {
      await deleteProviderImage(
          file: file, providerModel: providerModel, path: path);
      return await uploadProviderImage(
          file: file, providerModel: providerModel);
    } catch (error) {
      print('update provider image Error : ${error.toString()}');
    }
  }

  // ----------------------------------------

  deleteProviderImage(
      {required File file,
      required ProviderModel providerModel,
      required String path}) async {
    List pathList = path.split('/');
    path = 'profile_images/';
    path += pathList[pathList.length - 1];
    print('delete provider path : $path');
    try {
      await supabase.from('Fazzah_storage').remove([path]);
      ProviderModel temp =
          await SupaGetAndDelete().getProvider(providerModel.id!);
      temp.providerImage = null;
      await SupabaseUpdate().updateProviderProfileImage(
          providerID: providerModel.id!, providerImage: temp.providerImage!);
    } catch (error) {
      print('delete peovider image Error : ${error.toString()}');
    }
  }
}
