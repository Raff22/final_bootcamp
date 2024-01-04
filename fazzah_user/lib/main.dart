import 'package:easy_localization/easy_localization.dart';
import 'package:fazzah_user/bloc/auth_bloc/auth_bloc.dart';
import 'package:fazzah_user/bloc/chat_bloc/chat_bloc.dart';
import 'package:fazzah_user/bloc/booking/booking_bloc.dart';
import 'package:fazzah_user/bloc/is_provider_cubit/is_provider_cubit.dart';
import 'package:fazzah_user/bloc/order_bloc/order_bloc.dart';
import 'package:fazzah_user/bloc/payments_bloc/payments_bloc.dart';
import 'package:fazzah_user/bloc/provider_bloc/provider_bloc.dart';
import 'package:fazzah_user/bloc/provider_wallet/provider_wallet_bloc.dart';
import 'package:fazzah_user/bloc/visible_password_cubit/visible_password_cubit.dart';
import 'package:fazzah_user/views/auth_views/logo_view/logo_view.dart';
import 'package:fazzah_user/views/user_main_views/blocks/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fazzah_user/utils/helpers/supabase_initilizer.dart';
import 'package:fazzah_user/views/user_main_views/blocks/fav_bloc/fav_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_config/flutter_config.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await dotenv.load(fileName: ".env");
  supaInitializer();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
      supportedLocales: const [Locale('ar', 'SA'), Locale('en', 'US')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar', 'SA'),
      child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<VisiblePasswordCubit>(
          create: (context) => VisiblePasswordCubit(),
        ),
        BlocProvider<IsProviderCubit>(
          create: (context) => IsProviderCubit(),
        ),
        BlocProvider<FavBloc>(
          create: (context) => FavBloc(),
        ),
        BlocProvider<BookingBloc>(
          create: (context) => BookingBloc(),
        ),
        BlocProvider<ProviderBloc>(
          create: (context) => ProviderBloc(),
        ),
        BlocProvider(
          create: (context) => ChatBloc(),
        ),
        BlocProvider(
          create: (context) => OrderBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => PayBloc(),
        ),
        BlocProvider(
          create: (context) => WalletBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'SF-Arabic'),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: const LogoView(),
      ),
    );
  }
}
