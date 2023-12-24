abstract class AuthState {}

class InitialState extends AuthState {}

class SignUpSuccessedState extends AuthState {}

class LoginSuccessedState extends AuthState {}

class ErrorState extends AuthState {
  final String message;

  ErrorState(this.message);
}
