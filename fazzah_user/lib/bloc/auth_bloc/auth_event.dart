
abstract class AuthEvent {}

class SignUpUserEvent extends AuthEvent {
  final String fullName;
  final String email;
  final String password;
  final String phoneNumber;

  SignUpUserEvent(
      {required this.fullName,
      required this.email,
      required this.password,
      required this.phoneNumber});
}

class SignUpProviderEvent extends AuthEvent {
  final String fullName;
  final String email;
  final String password;
  final String phoneNumber;
  final String nationalty;
  final String nationalId;
  final String age;
  final String certificate;
  final String job;
  final String services;
  final String yearsOfExperience;
  final String priceRange;

  SignUpProviderEvent(
      {required this.fullName,
      required this.email,
      required this.password,
      required this.phoneNumber,
      required this.nationalty,
      required this.nationalId,
      required this.age,
      required this.certificate,
      required this.job,
      required this.services,
      required this.yearsOfExperience,
      required this.priceRange});
}

class OTPEvent extends AuthEvent {
  final String otp;
  final String email;
  final bool isProvider;

  OTPEvent({
    required this.isProvider,
    required this.otp,
    required this.email,
  });
}

class ResendOTPEvent extends AuthEvent {
  final String email;

  ResendOTPEvent({
    required this.email,
  });
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  final bool isProvider;

  LoginEvent(
      {required this.email, required this.password, required this.isProvider});
}


