import 'package:fazzah_user/constant/color.dart';
import 'package:fazzah_user/constant/layout.dart';
import 'package:fazzah_user/global/global_widget/text_widget.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.isMine,
    required this.isNew,
    required this.message,
  });
  final bool isMine;
  final bool isNew;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment:
            isMine ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomRight: isMine ? Radius.zero : const Radius.circular(20),
              bottomLeft: isMine ? const Radius.circular(20) : Radius.zero,
            ),
            child: Container(
              color: lightGreen,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextWidget(
                  text: message,
                  textSize: 18,
                ),
              ),
            ),
          ),
          width20,
          SizedBox(
              height: 50,
              width: 50,
              child: isNew ? Image.asset('assets/images/Logo.png') : null),
        ],
      ),
    );
  }
}
