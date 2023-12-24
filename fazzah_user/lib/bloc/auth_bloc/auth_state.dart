abstract class AuthStatee {}

class InitialState extends AuthStatee {}

class LoadingAuthState extends AuthStatee {}

class SignUpSuccessedState extends AuthStatee {}

class LoginSuccessedState extends AuthStatee {}

class ErrorAuthState extends AuthStatee {
  final String message;

  ErrorAuthState({required this.message});
}
