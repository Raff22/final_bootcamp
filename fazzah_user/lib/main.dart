import 'package:easy_localization/easy_localization.dart';
<<<<<<< HEAD
import 'package:fazzah_user/views/booking_views/providers_view.dart';
import 'package:fazzah_user/views/user_main_views/home_view.dart';
import 'package:fazzah_user/views/user_main_views/nav_bar.dart';
=======
import 'package:fazzah_user/views/booking_views/change_location_view.dart';
>>>>>>> main
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return MaterialApp(
        theme: ThemeData(fontFamily: 'SF-Arabic'),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
<<<<<<< HEAD
        home: NavBar());
=======
        home: const ChangeLocationView());
>>>>>>> main
  }
}
