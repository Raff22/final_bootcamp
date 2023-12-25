import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthStatee {}

class InitialState extends AuthStatee {}

class LoadingAuthState extends AuthStatee {}

class SignUpSuccessedState extends AuthStatee {}

class OTPSuccessedState extends AuthStatee {}

class LoginSuccessedState extends AuthStatee {
  final AuthResponse currentUser;

  LoginSuccessedState({required this.currentUser});
}

class ErrorAuthState extends AuthStatee {
  final String message;

  ErrorAuthState({required this.message});
}
