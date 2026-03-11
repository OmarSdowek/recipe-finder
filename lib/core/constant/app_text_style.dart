import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {

  // 🔹 Headings
  static final TextStyle headingLargeWarning = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.warningColor,
  );

  static final TextStyle headingMediumWhite = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.whiteColor,
  );
  static final TextStyle headingMediumBlack = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.blackColor,
  );
  static final TextStyle semibold18Black = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w800,
    color: AppColors.blackColor,
  );
  // 🔹 Body Text
  static final TextStyle bodyMediumHint = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.hintText2,
  );

  static final TextStyle bodyMediumSecondary = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryText,
  );

  static final TextStyle bodyRegularSecondary = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
  );

  static final TextStyle bodyBoldSecondary = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.hintText2,
  );

  // 🔹 Emphasized Text
  static final TextStyle bodyLargeBlackBold = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.blackColor,
  );

  static final TextStyle titleMediumWhiteBold = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteColor,
  );
}