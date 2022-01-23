import 'package:flutter/material.dart';

import 'colors.dart';

extension CustomColorSchemeX on ColorScheme {
  Color get mainColor => brightness == Brightness.light
      ? AppColors.blueLight
      : AppColors.brownColor;

  Color get mainColorLight => brightness == Brightness.light
      ? AppColors.blueLight100
      : AppColors.brownColorLight;
}
