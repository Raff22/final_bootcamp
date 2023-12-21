import 'package:easy_localization/easy_localization.dart';
import 'package:fazzah_user/views/auth_views/logo_view/logo_view.dart';
import 'package:fazzah_user/views/user_main_views/home_view.dart';
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
      debugShowCheckedModeBanner: false,
      home: MainView(),
    );
  }
}
