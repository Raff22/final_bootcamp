import 'package:fazzah_user/utils/imports.dart';

class LogoView extends StatefulWidget {
  const LogoView({super.key});

  @override
  State<LogoView> createState() => _LogoViewState();
}

class _LogoViewState extends State<LogoView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () async {
      final supa = Supabase.instance.client;
      final token = supa.auth.currentSession?.accessToken;
      if (token != null) {
        final isExpired = supa.auth.currentSession?.isExpired ?? false;
        if (isExpired) {
          await supa.auth.setSession(supa.auth.currentSession!.refreshToken!);
        }
        final String id = supa.auth.currentUser!.id;
        final UserModel? user = await SupaGet().getUser(userId: id);
        if (user != null) {
          context.removeUnitl(screen: NavBar(user: user));
        }
        final ProviderModel? provider = await SupaGet().getProvider(id);
        if (provider != null) {
          context.removeUnitl(
              screen: ProviderBookingRequestsView(providerModel: provider));
        }
      } else {
        context.removeUnitl(screen: const FirstOnboardingView());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(child: Image.asset('assets/images/logo_user.gif'))),
    );
  }
}
