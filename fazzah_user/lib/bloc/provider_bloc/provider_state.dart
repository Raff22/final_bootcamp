import 'package:fazzah_user/models/provider_model.dart';

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
