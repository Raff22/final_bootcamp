import 'package:bloc/bloc.dart';
import 'package:fazzah_user/models/message_model.dart';
import 'package:fazzah_user/models/user_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<GetUsersEvent>(getUsers);
    on<SendMessageEvent>(sendMessage);
  }
  final supabase = Supabase.instance.client;

  String getCurrentUserId = "690bdc94-c8e7-4a15-b583-3e3770739641";

// GetUsersEvent :
  getUsers(GetUsersEvent event, Emitter<ChatState> emit) async {
    try {
      final List allUsers =
          await supabase.from("users").select().neq("id", getCurrentUserId);

      final List<UserModel> users =
          allUsers.map((user) => UserModel.fromJson(user)).toList();

      emit(GetUsersSuccessedState(users));
    } catch (e) {
      print(e);
      emit(ErrorGetUsersState());
    }
  }

// SendMessageEvent :
  sendMessage(SendMessageEvent event, emit) async {
    try {
      final Message message = Message(
          content: event.message,
          fromUser: getCurrentUserId,
          toUser: "18530733-f14b-4ba7-a923-258341cb7705");
      await supabase.from("messages").insert(message.toJson());
    } catch (e) {
      print(e);
    }
  }

  Stream getMessages(String toUserId) {
    // -- listen to stream from (messages) table ,
    //    and get messages just between (current user) and (selected user)
    final allMesaages = supabase
        .from("messages")
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: true)
        .map((items) => items.where((element) =>
            element["from_user"] == getCurrentUserId &&
                element["to_user"] == toUserId ||
            element["from_user"] == toUserId &&
                element["to_user"] == getCurrentUserId));

// -- convert List<Map> to List<Message>
    final messages = allMesaages.map((items) =>
        items.map((item) => Message.fromJson(item, getCurrentUserId)).toList());

    return messages;
  }
}
