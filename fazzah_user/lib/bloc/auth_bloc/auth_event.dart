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
  final String pin1;
  final String pin2;
  final String pin3;
  final String pin4;

  OTPEvent(
    this.pin1,
    this.pin2,
    this.pin3,
    this.pin4,
  );
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}
