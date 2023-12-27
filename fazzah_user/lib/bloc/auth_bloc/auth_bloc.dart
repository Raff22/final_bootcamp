import 'package:fazzah_user/bloc/auth_bloc/auth_event.dart';
import 'package:fazzah_user/bloc/auth_bloc/auth_state.dart';
import 'package:fazzah_user/database/auth_supabase/aurth_supabase.dart';
import 'package:fazzah_user/database/get_data.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthStatee> {
  AuthBloc() : super(InitialState()) {
    //--------------------- Sign Up User Event ----------------------------
    on<SignUpUserEvent>((event, emit) async {
      try {
        emit(LoadingAuthSignupState());
        await AuthSupabase().signupUser(
            fullName: event.fullName,
            email: event.email,
            password: event.password,
            phoneNumber: event.phoneNumber);
        emit(SignUpSuccessedUserState());
      } catch (error) {
        emit(ErrorAuthSignupState(message: error.toString()));
      }
    });

    //--------------------- Sign Up Provider Event ----------------------------
    on<SignUpProviderEvent>((event, emit) async {
      try {
        emit(LoadingAuthSignupState());
        await AuthSupabase().signupProvider(
          fullName: event.fullName,
          email: event.email,
          password: event.password,
          phoneNumber: event.phoneNumber,
          nationalId: event.nationalId,
          nationalty: event.nationalty,
          age: event.age,
          certificate: event.certificate,
          job: event.job,
          services: event.services,
          yearsOfExperience: event.yearsOfExperience,
          priceRange: event.priceRange,
        );
        emit(SignUpSuccessedProviderState());
      } catch (error) {
        emit(ErrorAuthSignupState(message: error.toString()));
      }
    });

    //------------------ OTP Event ----------------------
    on<OTPEvent>((event, emit) async {
      print('1');
      try {
        print('2');
        emit(LoadingAuthOTPState());
        final currentUser = await AuthSupabase().otp(
          otp: event.otp,
          email: event.email,
        );
        print(currentUser);
        print('3');

        //---- get provider ----
        print('4');
        final ProviderModel? providerModel =
            await SupaGetAndDelete().getProviderRahaf(
          userId: currentUser.user!.id,
        );
        //---- get user ----
        print('5');
        final UserModel? userModel =
            await SupaGetAndDelete().getUser(userId: currentUser.user!.id);
        if (event.isProvider == true) {
          print('6');
          emit(OTPSuccessedProviderState(
              isProvider: event.isProvider, currentprovider: providerModel!));
        } else {
          print('7');
          emit(OTPSuccessedUserState(
              currentUser: userModel!, isProvider: event.isProvider));
        }
      } catch (error) {
        print('catch error ');
        emit(ErrorAuthOTPState(message: error.toString()));
      }
    });

    //--------------- Resend OTP Event ------------------
    on<ResendOTPEvent>((event, emit) async {
      try {
        await AuthSupabase().resendOTP(
          email: event.email,
        );
      } catch (error) {
        emit(ErrorAuthOTPState(message: error.toString()));
      }
    });

    //-----------------  Login Event --------------------
    on<LoginEvent>((event, emit) async {
      print('1');
      try {
        print('2');
        emit(LoadingAuthLoginState());
        final currentUser = await AuthSupabase().login(
          email: event.email,
          password: event.password,
        );
        print(currentUser);
        print('3');

        //---------------get provider -----------
        print('4');
        final ProviderModel? providerModel =
            await SupaGetAndDelete().getProviderRahaf(
          userId: currentUser.user!.id,
        );
        //---- get user ----
        print('5');
        final UserModel? userModel =
            await SupaGetAndDelete().getUser(userId: currentUser.user!.id);

        if (event.isProvider == true) {
          print('6');
          emit(LoginSuccessedProviderState(
            currentprovider: providerModel!,
            isProvider: event.isProvider,
          ));
        } else {
          print('7');
          emit(LoginSuccessedUserState(
            currentUser: userModel!,
            isProvider: event.isProvider,
          ));
        }
      } catch (error) {
        print('catch error ');
        emit(ErrorAuthLoginState(message: error.toString()));
      }
    });


  }
}
