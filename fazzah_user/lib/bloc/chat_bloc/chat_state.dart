part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class GetUsersSuccessedState extends ChatState {
  final List<ProviderModel> providera;

  GetUsersSuccessedState(this.providera);
}

final class ErrorGetUsersState extends ChatState {}
