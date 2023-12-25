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

  //------------------- OTP Supabase ------------------
  otp({
    required String otp,
    required String email,
  }) async {
    try {
      final response = await supabase.auth
          .verifyOTP(token: otp, type: OtpType.signup, email: email);

      print(
          "------- response OTP after sign up from supabase function --------");
      print(response.session);
    } on AuthException catch (error) {
      print("OTP Error catch : ${error.toString()}");
      throw 'رمز التحقق غير صحيح او منتهي صلاحيته';
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
      throw 'قم بتسجيل دخول';
    }
  }

  //-------------- Login Supabase ----------------
  login({
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
      throw 'البريد الإلكتروني او الرقم السري غير صحيح';
    }
  }

 
}
