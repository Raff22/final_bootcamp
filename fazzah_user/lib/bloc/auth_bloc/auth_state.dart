import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/user_model.dart';

abstract class AuthStatee {}

class InitialState extends AuthStatee {}

class LoadingAuthSignupState extends AuthStatee {}

class LoadingAuthOTPState extends AuthStatee {}

class LoadingAuthLoginState extends AuthStatee {}



class SignUpSuccessedUserState extends AuthStatee {}

class SignUpSuccessedProviderState extends AuthStatee {}

class OTPSuccessedUserState extends AuthStatee {
  final UserModel? currentUser;
  final bool isProvider;

  OTPSuccessedUserState({required this.isProvider, required this.currentUser});
}

class OTPSuccessedProviderState extends AuthStatee {
  final ProviderModel? currentprovider;
  final bool isProvider;

  OTPSuccessedProviderState(
      {required this.isProvider, required this.currentprovider});
}

class LoginSuccessedUserState extends AuthStatee {
  final UserModel currentUser;

  final bool isProvider;

  LoginSuccessedUserState(
      {required this.isProvider, required this.currentUser});
}

class LoginSuccessedProviderState extends AuthStatee {
  final ProviderModel currentprovider;
  final bool isProvider;

  LoginSuccessedProviderState(
      {required this.currentprovider, required this.isProvider});
}

class ErrorAuthSignupState extends AuthStatee {
  final String message;

  ErrorAuthSignupState({required this.message});
}
class ErrorAuthOTPState extends AuthStatee {
  final String message;

  ErrorAuthOTPState({required this.message});
}
class ErrorAuthLoginState extends AuthStatee {
  final String message;

  ErrorAuthLoginState({required this.message});
}
