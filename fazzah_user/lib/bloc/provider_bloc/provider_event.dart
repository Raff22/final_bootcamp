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
