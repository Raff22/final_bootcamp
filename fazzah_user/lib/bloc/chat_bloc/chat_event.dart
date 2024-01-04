part of 'chat_bloc.dart';

sealed class ChatEvent {}

class GetUsersEvent extends ChatEvent {}

class getProviders extends ChatEvent {}

class GetProviderEvent extends ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final String message;
  final String toUserId;

  SendMessageEvent(this.message, this.toUserId);
}
