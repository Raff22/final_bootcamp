// ignore_for_file: use_build_context_synchronously

import 'package:fazzah_user/database/get_data.dart';
import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/user_model.dart';
import 'package:fazzah_user/utils/extentions/navigaton_extentions.dart';
import 'package:fazzah_user/views/auth_views/onboarding_view/first_onboarding_view.dart';
import 'package:fazzah_user/views/provider_view/provider_booking_requests_view.dart';
import 'package:fazzah_user/views/user_main_views/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
