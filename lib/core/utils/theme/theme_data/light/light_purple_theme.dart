
import 'package:flutter/material.dart';

import '../../../../../packeges/utils/material.dart';

ThemeData getLightPurpleTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundLightPurple,
    brightness: Brightness.light,
    // fontFamily: AppFonts.manrope,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryLightPurple300,
      brightness: Brightness.light,
    ),
    textTheme: ThemeData.light().textTheme.apply(
      bodyColor: AppColors.grey900,
      displayColor: AppColors.grey900,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLightPurple300,
        foregroundColor: AppColors.grey0,
        disabledBackgroundColor: AppColors.grey100,
        disabledForegroundColor: AppColors.grey0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: TextStyles.semiBold(),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.grey100,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.grey100,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.primaryLightPurple200,
        ),
      ),
      fillColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return AppColors.primaryLightPurple0;
        }
        return AppColors.grey0;
      }),
      filled: true,
      hintStyle: TextStyles.regular().copyWith(color: AppColors.grey400),
    ),
  );
}
