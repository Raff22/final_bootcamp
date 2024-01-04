import 'package:fazzah_user/utils/imports.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({
    super.key,
    required this.controller,
    required this.toUserId,
  });

  final TextEditingController controller;
  final String toUserId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 20),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Colors.white),
      child: TextField(
        minLines: 1,
        maxLines: 4,
        controller: controller,
        decoration: InputDecoration(
            hintText: "send message",
            hintStyle: const TextStyle(color: Colors.grey),
            suffixIcon: IconButton(
              onPressed: () {
                context
                    .read<ChatBloc>()
                    .add(SendMessageEvent(controller.text, toUserId));
                controller.clear();
              },
              icon: const Icon(Icons.send),
            ),
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
