import 'package:brick_breaker_game/base/utils/asset_resource.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.defaultColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: AppColors.defaultColor,
        ),
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.defaultColor,
          centerTitle: true),
      inputDecorationTheme: const InputDecorationTheme(
        errorStyle: TextStyle(
            color: AppColors.redColor, fontFamily: AssetResource.appFontName),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 0.0)),
      ),
      textTheme: const TextTheme(
        bodyText1: TextStyle(fontFamily: AssetResource.appFontName),
        bodyText2: TextStyle(fontFamily: AssetResource.appFontName),
        subtitle1: TextStyle(fontFamily: AssetResource.appFontName),
        subtitle2: TextStyle(fontFamily: AssetResource.appFontName),
        headline4: TextStyle(
            fontFamily: AssetResource.appFontName,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        headline5: TextStyle(fontFamily: AssetResource.appFontName),
        headline6: TextStyle(fontFamily: AssetResource.appFontName),
        button: TextStyle(fontFamily: AssetResource.appFontName, fontSize: 16),
      ),
    );
  }
}
