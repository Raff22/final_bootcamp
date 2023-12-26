part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class GetUsersSuccessedState extends ChatState {
  final List<ProviderModel> providera;

  GetUsersSuccessedState(this.providera);
}

final class GetPrividerSuccessedState extends ChatState {
  final List<UserModel> users;

  GetPrividerSuccessedState(this.users);
}

final class ErrorGetUsersState extends ChatState {}
