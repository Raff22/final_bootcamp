import 'package:fazzah_user/utils/imports.dart';

class ProviderchatScreen extends StatelessWidget {
  ProviderchatScreen({super.key, required this.provider});
  final UserModel provider;
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

            return ListView.builder(
                padding: const EdgeInsets.only(bottom: 100),
                shrinkWrap: true,
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
