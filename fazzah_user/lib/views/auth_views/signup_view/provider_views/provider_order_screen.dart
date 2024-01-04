import 'package:fazzah_user/utils/imports.dart';

class ProviderOrderScreen extends StatelessWidget {
  const ProviderOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const mainScreenAppbar(title: "الطلبات"),
          ElevatedButton(
              onPressed: () {
                context.pushScreen(screen: const ProviderChat());
              },
              child: const Text("orders"))
        ],
      ),
    );
  }
}
