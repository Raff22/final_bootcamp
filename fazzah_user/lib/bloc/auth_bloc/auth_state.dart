import 'package:fazzah_user/models/user_model.dart';

abstract class AuthStatee {}

class InitialState extends AuthStatee {}

class LoadingAuthState extends AuthStatee {}

class SignUpSuccessedState extends AuthStatee {}

class OTPSuccessedState extends AuthStatee {
  final UserModel currentUser;

  OTPSuccessedState({required this.currentUser});
}

class LoginSuccessedState extends AuthStatee {
  final UserModel currentUser;

  LoginSuccessedState({required this.currentUser});
}

class ErrorAuthState extends AuthStatee {
  final String message;

  ErrorAuthState({required this.message});
}
