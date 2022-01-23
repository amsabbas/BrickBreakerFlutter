import 'package:brick_breaker_game/base/injection/general_injection.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'base/language/language.dart';
import 'base/style/theme.dart';
import 'screen/cover_screen.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await initGeneralInjection();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    setLocale(const Locale("en"));
    return GetMaterialApp(
      locale: _locale,
      translations: Language(),
      home: const CoverScreen(),
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
    );
  }
}
