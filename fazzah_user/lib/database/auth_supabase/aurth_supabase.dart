import 'package:supabase_flutter/supabase_flutter.dart';

class AuthSupabase {
  final supabase = Supabase.instance.client;

  //---------------------------------------------------
  signup(
      {required String fullName,
      required String email,
      required String password,
      required String phoneNumber}) async {
    try {
      final response =
          await supabase.auth.signUp(password: password, email: email);

      await supabase.from('users').insert(
          {'name': fullName, 'phone_number': phoneNumber, 'email': email});

      print("------- response sign up from supabase function --------");
      print(response);
    } catch (error) {
      print("Signup Error catch : ${error.toString()}");
    }
  }
  //---------------------------------------------------

  //---------------------------------------------------
  otp({
    required String otp,
    required String email,
  }) async {
    try {
      final response = await supabase.auth
          .verifyOTP(token: otp, type: OtpType.signup, email: email);

      print(
          "------- response OTP after sign up from supabase function --------");
      print(response);
    } on AuthException catch (error) {
      print("OTP Error catch : ${error.toString()}");
      throw 'رمز التحقق غير صحيح او منتهي صلاحيته';
    }
  }
}
