import 'dart:io';

import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/working_hours_model.dart';

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
  ProviderModel provider;
  final String? name;
  final String? nationalID;
  final String? phoneNumber;
  final String? nationality;
  final String? job;

  UpdateProviderAccountInfo(
      {required this.provider,
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

class GetProviderWorkingHoursEvent extends ProviderEvent {
  final String providerID;

  GetProviderWorkingHoursEvent({required this.providerID});
}

class UpdateProviderWorkingHours extends ProviderEvent {
  final WorkingHours wHours;

  UpdateProviderWorkingHours({required this.wHours});
}

class SelectHourSwitchEvent extends ProviderEvent {
  final List<bool> wHours;

  SelectHourSwitchEvent({required this.wHours});
}

class GetAddressByID extends ProviderEvent {
  final int addressID;

  GetAddressByID({required this.addressID});
}
