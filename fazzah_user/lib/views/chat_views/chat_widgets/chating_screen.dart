import 'package:fazzah_user/bloc/chat_bloc/chat_bloc.dart';
import 'package:fazzah_user/models/message_model.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/user_model.dart';
import 'package:fazzah_user/views/chat_views/chat_widgets/chat_bubble.dart';
import 'package:fazzah_user/views/chat_views/chat_widgets/chat_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.provider});
  final ProviderModel provider;
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChatBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(provider.name ?? ""),
      ),
      bottomSheet: ChatTextField(
        controller: messageController,
        toUserId: provider.id!,
      ),
      body: StreamBuilder(
        stream: bloc.getMessages(provider.id!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Message> messages = snapshot.data!;
            ScrollController scrollController = ScrollController();

            Future.delayed(const Duration(milliseconds: 100 ~/ 60), () {
              scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.linear);
            });

            return ListView.builder(
                padding: const EdgeInsets.only(bottom: 100),
                shrinkWrap: true,
                controller: scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ChatBubble(
                      message: messages[index].content ?? "",
                      isMine: messages[index].isMine ?? true);
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
