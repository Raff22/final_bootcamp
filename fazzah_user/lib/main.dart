import 'package:easy_localization/easy_localization.dart';
import 'package:fazzah_user/bloc/visible_password/visible_password_cubit.dart';
import 'package:fazzah_user/views/auth_views/logo_view/logo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('ar', 'SA')],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: const Locale('ar', 'SA'),
        child: const MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VisiblePasswordCubit>(
          create: (context) => VisiblePasswordCubit(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LogoView(),
      ),
    );
  }
}
