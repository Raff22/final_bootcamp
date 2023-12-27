import 'package:fazzah_user/models/provider_model.dart';

abstract class ProviderState {}

class InitialProviderState extends ProviderState {}

class LoadingImageProviderState extends ProviderState {}

class SuccessUploadedImageState extends ProviderState {
  final ProviderModel providerModel;

  SuccessUploadedImageState({required this.providerModel});
}
