import 'package:easy_localization/easy_localization.dart';
<<<<<<< HEAD
import 'package:fazzah_user/views/booking_views/providers_view.dart';
import 'package:fazzah_user/views/user_main_views/blocks/fav_bloc/fav_bloc.dart';
import 'package:fazzah_user/views/user_main_views/home_view.dart';
import 'package:fazzah_user/views/user_main_views/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
=======
import 'package:fazzah_user/views/chat_views/chat_with_provider_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
>>>>>>> main

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
      supportedLocales: const [Locale('ar', 'SA'), Locale('en', 'US')],
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('ar', 'SA'),
      child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return BlocProvider(
      create: (context) => FavBloc(),
      child: MaterialApp(
          theme: ThemeData(fontFamily: 'SF-Arabic'),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: NavBar()),
    );
=======
    return MaterialApp(
        theme: ThemeData(fontFamily: 'SF-Arabic'),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: const ChatWithProviderView());
>>>>>>> main
  }
}
