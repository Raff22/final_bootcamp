import 'package:supabase_flutter/supabase_flutter.dart';

class AuthSupabase {
  final supabase = Supabase.instance.client;

  //------------------- Sign Up Supabase User -----------------------------
  signupUser(
      {required String fullName,
      required String email,
      required String password,
      required String phoneNumber}) async {
    try {
      final response =
          await supabase.auth.signUp(password: password, email: email);
      await supabase.from('users').insert({
        'id': response.user!.id,
        'name': fullName,
        'phone_number': phoneNumber,
        'email': email
      });
      print("------- response sign up from supabase function --------");
      print(response.user!.id);
    } on PostgrestException catch (error) {
      print("signup Error catch : ${error.toString()}");
      throw 'البريد الإلكتروني مستخدم';
    } on AuthException catch (error) {
      print("signup Error catch : ${error.toString()}");
      throw 'الرجاء المحاولة بعد ساعة';
    } catch (error) {
      print("Signup Error catch : ${error.toString()}");
    }
  }

  //------------------- Sign Up Supabase Provider -----------------------------
  signupProvider(
      {required String fullName,
      required String email,
      required String password,
      required String phoneNumber,
      required String nationalty,
      required String nationalId,
      required String age,
      required String certificate,
      required String job,
      required String services,
      required String yearsOfExperience,
      required String priceRange}) async {
    try {
      final response =
          await supabase.auth.signUp(password: password, email: email);
      await supabase.from('providers').insert({
        'id': response.user!.id,
        'name': fullName,
        'phone_number': phoneNumber,
        'email': email,
        'id_number': nationalId,
        'nationality': nationalty,
        'age': age,
        'certificate': certificate,
        'job': job,
        'price_range': priceRange,
        'experience': yearsOfExperience,
        'services': services,
      });
      print("------- response sign up from supabase function --------");
      print(response.user!.id);
    } on PostgrestException catch (error) {
      print("signup Error catch : ${error.toString()}");
      throw 'البريد الإلكتروني مستخدم';
    } on AuthException catch (error) {
      print("signup Error catch : ${error.toString()}");
      throw 'الرجاء المحاولة بعد ساعة';
    } catch (error) {
      print("Signup Error catch : ${error.toString()}");
    }
  }

  //------------------- OTP Supabase ------------------
  Future<AuthResponse> otp({
    required String otp,
    required String email,
  }) async {
    try {
      final response = await supabase.auth
          .verifyOTP(token: otp, type: OtpType.signup, email: email);

      print(
          "------- response OTP after sign up from supabase function --------");
      print(response.session);
      return response;
    } on AuthException catch (error) {
      print("OTP Error catch : ${error.toString()}");
      throw error.message;
    }
  }

  //-------------- Resend OTP Supabase ----------------
  Future<ResendResponse> resendOTP({
    required String email,
  }) async {
    try {
      final response =
          await supabase.auth.resend(type: OtpType.signup, email: email);

      print(
          "------- response resend OTP after sign up from supabase function --------");
      print(response.messageId);
      return response;
    } on AuthException catch (error) {
      print("Resend OTP Error catch : ${error.toString()}");
      throw error.message;
    }
  }

  //-------------- Login Supabase ----------------
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth
          .signInWithPassword(password: password, email: email);

      print("------- response login in from supabase function --------");
      print(response);
      return response;
    } on AuthException catch (error) {
      print("Login Error catch : ${error.toString()}");
      throw error.message;
    }
  }

  signOut() async {
    try {
      await supabase.auth.signOut();
    } on AuthException catch (e) {
      throw AuthException(e.message);
    }
  }

  deletAccount({required String id, required bool isProvider}) async {
    if (isProvider == false) {
      await supabase.from('users').delete().match({id: 'id'});
    } else {
      await supabase.from('providers').delete().match({id: 'id'});
    }
    await supabase.from('auth.users').delete().match({id: 'user-id'});
  }
}
