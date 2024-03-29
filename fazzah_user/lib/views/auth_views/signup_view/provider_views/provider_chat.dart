import 'package:fazzah_user/utils/imports.dart';

class ProviderChat extends StatefulWidget {
  const ProviderChat({super.key});

  @override
  State<ProviderChat> createState() => _ProviderChatState();
}

class _ProviderChatState extends State<ProviderChat> {
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    context.read<ChatBloc>().add(GetProviderEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Users",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () async {
                // await Supabase.instance.client.auth.signOut();
                // if (mounted) {
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => NavBar()));
                // }
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is GetPrividerSuccessedState) {
            return ListView.separated(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Providerchattest(
                                  user: state.users[index],
                                )));
                  },
                  child: ListTile(
                    title: Text(state.users[index].name ?? ""),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            );
          } else if (state is ErrorGetUsersState) {
            return const Text("error!!");
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
