import 'dart:io';

import 'package:fazzah_user/models/provider_model.dart';

abstract class ProviderEvent {}

class UploadProviderImageEvent extends ProviderEvent {
  final File imageFile;
  final ProviderModel? providerModel;

  UploadProviderImageEvent({
    required this.imageFile,
    this.providerModel,
  });
}

class UpdateProviderImageEvent extends ProviderEvent {
  final File imageFile;
  final ProviderModel? providerModel;

  UpdateProviderImageEvent({
    required this.imageFile,
    this.providerModel,
  });
}

class UpdateProviderAccountInfo extends ProviderEvent {
  final String providerID;
  final String? name;
  final String? nationalID;
  final String? phoneNumber;
  final String? nationality;
  final String? job;

  UpdateProviderAccountInfo(
      {required this.providerID,
      this.name,
      this.nationalID,
      this.phoneNumber,
      this.nationality,
      this.job});
}

class GetProviderData extends ProviderEvent {
  final String providerID;

  GetProviderData({required this.providerID});

}
