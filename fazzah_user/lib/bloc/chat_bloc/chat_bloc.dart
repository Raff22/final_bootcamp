import 'package:bloc/bloc.dart';
import 'package:fazzah_user/database/get_data.dart';
import 'package:fazzah_user/models/message_model.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/user_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<GetUsersEvent>(getUsers);
    on<GetProviderEvent>(getProviders);

    on<SendMessageEvent>(sendMessage);
  }
  final supabase = Supabase.instance.client;

// GetUsersEvent :
  getUsers(GetUsersEvent event, Emitter<ChatState> emit) async {
    try {
      String getCurrentUserId = supabase.auth.currentUser!.id;

      final List<ProviderModel> providers = await SupaGet().getAllProviders();

      emit(GetUsersSuccessedState(providers));
      print("here is error");
    } catch (e) {
      print(e);
      emit(ErrorGetUsersState());
    }
  }

  getProviders(GetProviderEvent event, Emitter<ChatState> emit) async {
    try {
      String getCurrentUserId = supabase.auth.currentUser!.id;

      final List<UserModel> users = await SupaGet().getAllusers();

      emit(GetPrividerSuccessedState(users));
      print("here is error");
    } catch (e) {
      print(e);
      emit(ErrorGetUsersState());
    }
  }

  sendMessage(SendMessageEvent event, emit) async {
    try {
      String getCurrentUserId = supabase.auth.currentUser!.id;

      final Message message = Message(
          content: event.message,
          fromUser: getCurrentUserId,
          toUser: event.toUserId);
      await supabase.from("messages").insert(message.toJson());
    } catch (e) {
      print(e);
    }
  }

  Stream getMessages(String toUserId) {
    String getCurrentUserId = supabase.auth.currentUser!.id;

    final allMesaages = supabase
        .from("messages")
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: true)
        .map((items) => items.where((element) =>
            element["from_user"] == getCurrentUserId &&
                element["to_user"] == toUserId ||
            element["from_user"] == toUserId &&
                element["to_user"] == getCurrentUserId));

    final messages = allMesaages.map((items) =>
        items.map((item) => Message.fromJson(item, getCurrentUserId)).toList());

    return messages;
  }
}
