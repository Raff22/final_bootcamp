import 'package:fazzah_user/bloc/provider_bloc/provider_event.dart';
import 'package:fazzah_user/bloc/provider_bloc/provider_state.dart';
import 'package:fazzah_user/database/get_data.dart';
import 'package:fazzah_user/database/supabse_storage.dart';
import 'package:fazzah_user/database/update_data.dart';
import 'package:fazzah_user/global/globals_data/globals_data.dart';
import 'package:fazzah_user/models/address.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/working_hours_model.dart';
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
      if (event.name != null && event.name!.isNotEmpty) {
        event.provider.name = event.name!;
      }
      if (event.phoneNumber != null && event.phoneNumber!.isNotEmpty) {
        event.provider.phoneNumber = event.phoneNumber!;
      }
      event.provider.nationality = event.nationality!;
      event.provider.idNumber = event.nationalID!;
      event.provider.job = event.job!;
      try {
        await SupabaseUpdate().updateProvider(event.provider);
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

    on<GetProviderWorkingHoursEvent>((event, emit) async {
      emit(LoadingUpdateProviderAccountState());
      try {
        WorkingHours workHours = await SupaGet()
            .getProviderWorkingHours(providerId: event.providerID);
        emit(ShowProviderTheirWorkingHours(wHours: workHours));
      } catch (error) {
        print(error.toString());
        emit(ErrorUpdateProviderAccountState(errorMessage: error.toString()));
      }
    });

    on<SelectHourSwitchEvent>((event, emit) async {
      emit(UpdateHourSwitchState(wHours: event.wHours));
    });

    on<UpdateProviderWorkingHours>((event, emit) async {
      try {
        await SupabaseUpdate().updateWorkingHours(event.wHours);
        emit(UpdatedProviderWorkingHoursSuccessState());
      } catch (error) {
        print(error.toString());
        emit(ErrorUpdateProviderAccountState(errorMessage: error.toString()));
      }
    });

    //--------------- get address id --------------------
    on<GetAddressByID>((event, emit) async {
      final Address address =
          await SupaGet().getAddressesById(id: event.addressID);

      emit(GetOrderAddressUserState(address: address));
    });
  }
}
