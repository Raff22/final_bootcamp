import 'package:fazzah_user/bloc/provider_bloc/provider_event.dart';
import 'package:fazzah_user/bloc/provider_bloc/provider_state.dart';
import 'package:fazzah_user/database/supabse_storage.dart';
import 'package:fazzah_user/global/globals_data/globals_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProviderBloc extends Bloc<ProviderEvent, ProviderState> {
  ProviderBloc() : super(InitialProviderState()) {
    //-------- upload provider image ---------
    on<UploadProviderImageEvent>((event, emit) async {
      emit(LoadingImageProviderState());
      if (profileImage == null || profileImage!.isEmpty) {
        profileImage = await SupaStorage().uploadProviderImage(
            file: event.imageFile, providerModel: event.providerModel!);
        print(':::::::::::::::::::::::::::::;');
        print(profileImage);
        emit(SuccessUploadedImageState(providerModel: event.providerModel!));
      } else {
        profileImage = await SupaStorage().updateProviderImage(
            file: event.imageFile,
            providerModel: event.providerModel!,
            path: profileImage!);
        print(':::::::::::::::::::::::::::::;');
        print(profileImage);
        emit(SuccessUploadedImageState(providerModel: event.providerModel!));
      }
    });

    // on<UploadProviderImageEvent>((event, emit) async {
    //   emit(LoadingImageProviderState());
    //   if (profileImage == null || profileImage!.isEmpty) {
    //     profileImage = await SupaStorage().uploadProviderImage(
    //         file: event.imageFile, providerModel: event.providerModel!);

    //     emit(SuccessUploadedImageState());
    //   } else {
    //     profileImage = await SupaStorage().updateProviderImage(
    //         file: event.imageFile,
    //         providerModel: event.providerModel!,
    //         path: profileImage!);
    //   }
    // });
  }
}
