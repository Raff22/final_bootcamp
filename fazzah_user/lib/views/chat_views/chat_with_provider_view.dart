import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/utils/helpers/appbar_creator.dart';
import 'package:fazzah_user/views/chat_views/chat_widgets/chat_bubble.dart';
import 'package:fazzah_user/views/chat_views/chat_widgets/chat_textfield.dart';
import 'package:flutter/material.dart';

class ChatWithProviderView extends StatelessWidget {
  const ChatWithProviderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: const ChatField(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: createAppBar(
            title: "محادثة الفني",
            context: context,
            leading: IconButton(
                onPressed: () {
                  context.popScreen();
                },
                icon:
                    const Icon(Icons.arrow_back_ios, size: 20, color: black))),
        body: SizedBox(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(DateTime.timestamp().toString()),
              const ChatBubble(
                isMine: false,
                isNew: true,
                message: 'السلام عليكم',
              ),
              const ChatBubble(
                isMine: false,
                isNew: false,
                message: 'أنا عند الباب',
              ),
              const ChatBubble(
                isMine: true,
                isNew: false,
                message: "وعليكم السلام",
              ),
              const ChatBubble(
                isMine: true,
                isNew: false,
                message: "تمام",
              ),
              const ChatBubble(
                isMine: false,
                isNew: true,
                message: "هاذي الأغراض",
              )
            ],
          ),
        ));
  }
}
