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

class OTPEvent extends AuthEvent {
  final String otp;
  final String email;

  OTPEvent({required this.otp, required this.email});
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}
