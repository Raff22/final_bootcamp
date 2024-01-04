import 'package:fazzah_user/utils/imports.dart';

class Providerchattest extends StatelessWidget {
  Providerchattest({super.key, required this.user});
  final UserModel user;
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChatBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name ?? ""),
      ),
      bottomSheet: ChatTextField(
        controller: messageController,
        toUserId: user.id!,
      ),
      body: StreamBuilder(
        stream: bloc.getMessages(user.id!),
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
