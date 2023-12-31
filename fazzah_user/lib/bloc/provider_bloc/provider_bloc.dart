import 'package:fazzah_user/bloc/provider_bloc/provider_event.dart';
import 'package:fazzah_user/bloc/provider_bloc/provider_state.dart';
import 'package:fazzah_user/database/get_data.dart';
import 'package:fazzah_user/database/supabse_storage.dart';
import 'package:fazzah_user/database/update_data.dart';
import 'package:fazzah_user/global/globals_data/globals_data.dart';
import 'package:fazzah_user/models/provider_model.dart';
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
        emit(SuccessUploadedImageState(providerImagePath: profileImage!));
      } else {
        profileImage = await SupaStorage().updateProviderImage(
            file: event.imageFile,
            providerModel: event.providerModel!,
            path: profileImage!);
        print(':::::::::::::::::::::::::::::;');
        print(profileImage);
        emit(SuccessUploadedImageState(providerImagePath: profileImage!));
      }
    });

    on<UpdateProviderAccountInfo>((event, emit) async {
      emit(LoadingUpdateProviderAccountState());
      try {
        await SupabaseUpdate().updateProviderAccountInfo(
          providerID: event.providerID,
          name: event.name,
          nationalID: event.nationalID,
          nationality: event.nationality,
          phoneNumber: event.phoneNumber,
          job: event.job,
        );

        emit(SuccessUpdateProviderAccountState());
      } catch (error) {
        print(error);
        emit(ErrorUpdateProviderAccountState(errorMessage: error.toString()));
      }
    });

    on<GetProviderData>((event, emit) async {
      emit(LoadingUpdateProviderAccountState());
      try {
        final ProviderModel? providerModel = await SupaGet().getProviderRahaf(
          userId: event.providerID,
        );
        emit(SuccessUpdateProviderAccountState(providerModel: providerModel));
      } catch (error) {
        print(error);
        emit(ErrorUpdateProviderAccountState(errorMessage: error.toString()));
      }
    });
  }
}
