import 'package:brick_breaker_game/base/injection/general_injection.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'base/style/theme.dart';
import 'screen/cover_screen.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  changeStatusBarColor();
  await initGeneralInjection();
  runApp(const MyApp());
}

void changeStatusBarColor() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.white),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const CoverScreen(),
      theme: CustomTheme.lightTheme,
    );
  }
}
