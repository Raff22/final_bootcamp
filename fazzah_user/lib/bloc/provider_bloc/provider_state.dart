import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/working_hours_model.dart';

abstract class ProviderState {}

class InitialProviderState extends ProviderState {}

class LoadingImageProviderState extends ProviderState {}

class SuccessUploadedImageState extends ProviderState {
  final String providerImagePath;

  SuccessUploadedImageState({required this.providerImagePath});
}

class LoadingUpdateProviderAccountState extends ProviderState {}

class SuccessUpdateProviderAccountState extends ProviderState {
  final ProviderModel? providerModel;

  SuccessUpdateProviderAccountState({this.providerModel});
}

class ErrorUpdateProviderAccountState extends ProviderState {
  final String errorMessage;

  ErrorUpdateProviderAccountState({required this.errorMessage});
}

class ShowProviderTheirWorkingHours extends ProviderState {
  final WorkingHours wHours;

  ShowProviderTheirWorkingHours({required this.wHours});
}

class UpdateHourSwitchState extends ProviderState {
  final List<bool> wHours;

  UpdateHourSwitchState({required this.wHours});
}

class UpdatedProviderWorkingHoursSuccessState extends ProviderState {}
