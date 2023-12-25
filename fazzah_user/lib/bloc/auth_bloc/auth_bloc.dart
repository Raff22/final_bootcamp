import 'package:fazzah_user/bloc/auth_bloc/auth_event.dart';
import 'package:fazzah_user/bloc/auth_bloc/auth_state.dart';
import 'package:fazzah_user/database/auth_supabase/aurth_supabase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthStatee> {
  AuthBloc() : super(InitialState()) {
    //--------------------------------------------------
    on<SignUpUserEvent>((event, emit) async {
      try {
        emit(LoadingAuthState());
        await AuthSupabase().signup(
            fullName: event.fullName,
            email: event.email,
            password: event.password,
            phoneNumber: event.phoneNumber);
        emit(SignUpSuccessedState());
      } catch (error) {
        emit(ErrorAuthState(message: error.toString()));
      }
    });

    //---------------------------------------------------

    //---------------------------------------------------
    on<OTPEvent>((event, emit) async {
      try {
        emit(LoadingAuthState());
        await AuthSupabase().otp(
          otp: event.otp,
          email: event.email,
        );

        emit(OTPSuccessedState());
      } catch (error) {
        emit(ErrorAuthState(message: error.toString()));
      }
    });
    //---------------------------------------------------

    //---------------------------------------------------
    on<ResendOTPEvent>((event, emit) async {
      try {
        await AuthSupabase().resendOTP(
          email: event.email,
        );
      } catch (error) {
        emit(ErrorAuthState(message: error.toString()));
      }
    });
    //---------------------------------------------------

    //--------------------------------------------------
    on<LoginEvent>((event, emit) async {
      try {
        emit(LoadingAuthState());
        final currentUser = await AuthSupabase().login(
          email: event.email,
          password: event.password,
        );
        emit(LoginSuccessedState(currentUser: currentUser));
      } catch (error) {
        emit(ErrorAuthState(message: error.toString()));
      }
    });

    //---------------------------------------------------
  }
}
