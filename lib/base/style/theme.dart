import 'package:brick_breaker_game/base/utils/asset_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.blueLight,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: AppColors.blueLight,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        primary: AppColors.blueLight,
      )),
      appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: AppColors.whiteColor,
            // Status bar brightness
            statusBarIconBrightness: Brightness.dark,
            // For Android (dark icons)
            statusBarBrightness: Brightness.dark, // For iOS (dark icons)
          ),
          backgroundColor: Colors.white,
          foregroundColor: AppColors.blueLight,
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

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.brownColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: AppColors.brownColor,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        primary: AppColors.brownColor,
      )),
      appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: AppColors.darkStatusBarColor,
            // Status bar brightness
            statusBarIconBrightness: Brightness.light,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          foregroundColor: AppColors.brownColor,
          centerTitle: true),
      inputDecorationTheme: const InputDecorationTheme(
        errorStyle: TextStyle(
            color: AppColors.redColor, fontFamily: AssetResource.appFontName),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.brownColor, width: 2)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.brownColor, width: 0.0)),
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
