import 'package:flutter/material.dart';
import 'package:food_app/core/constant/app_colors.dart';

class AppTheme {

  // 🌞 Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light, // ثيم فاتح

    scaffoldBackgroundColor: AppColors.scaffoldBackground,

    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryBlue,
      secondary: AppColors.secondaryBlue,

      background: AppColors.whiteColor,
      surface: AppColors.cardBackground,

      onBackground: AppColors.blackColor,
      onSurface: AppColors.primaryText,

      onSurfaceVariant: AppColors.secondaryText,
    ),
  );

  // 🌙 Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark, // ثيم غامق

    scaffoldBackgroundColor: Colors.black,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.secondaryBlue,
      secondary: AppColors.primaryBlue,

      background: Colors.black,
      surface: Color(0xFF1E1E1E),

      onBackground: Colors.white,
      onSurface: Colors.white,

      onSurfaceVariant: Colors.grey,
    ),
  );
}