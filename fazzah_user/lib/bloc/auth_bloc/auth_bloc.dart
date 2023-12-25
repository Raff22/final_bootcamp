import 'package:fazzah_user/bloc/auth_bloc/auth_event.dart';
import 'package:fazzah_user/bloc/auth_bloc/auth_state.dart';
import 'package:fazzah_user/database/auth_supabase/aurth_supabase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthBloc extends Bloc<AuthEvent, AuthStatee> {
  AuthBloc() : super(InitialState()) {
    //--------------------- Sign Up User Event ----------------------------
    on<SignUpUserEvent>((event, emit) async {
      try {
        emit(LoadingAuthState());
        await AuthSupabase().signupUser(
            fullName: event.fullName,
            email: event.email,
            password: event.password,
            phoneNumber: event.phoneNumber);
        emit(SignUpSuccessedState());
      } catch (error) {
        emit(ErrorAuthState(message: error.toString()));
      }
    });

    //------------------ OTP Event ----------------------
    on<OTPEvent>((event, emit) async {
      try {
        emit(LoadingAuthState());
        final AuthResponse currentUser = await AuthSupabase().otp(
          otp: event.otp,
          email: event.email,
        );

        emit(OTPSuccessedState(currentUser));
      } catch (error) {
        emit(ErrorAuthState(message: error.toString()));
      }
    });

    //--------------- Resend OTP Event ------------------
    on<ResendOTPEvent>((event, emit) async {
      try {
        await AuthSupabase().resendOTP(
          email: event.email,
        );
      } catch (error) {
        emit(ErrorAuthState(message: error.toString()));
      }
    });

    //-----------------  Login Event --------------------
    on<LoginEvent>((event, emit) async {
      try {
        emit(LoadingAuthState());
        final AuthResponse currentUser = await AuthSupabase().login(
          email: event.email,
          password: event.password,
        );
        emit(LoginSuccessedState(currentUser: currentUser));
      } catch (error) {
        emit(ErrorAuthState(message: error.toString()));
      }
    });
  }
}
