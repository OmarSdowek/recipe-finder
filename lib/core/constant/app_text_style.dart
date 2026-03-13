import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {

  // 🔹 Headings
  static final TextStyle headingLargeWarning = TextStyle(
    fontSize: 36.sp,
    fontWeight: FontWeight.w800,
    color: AppColors.whiteColor,
  );
  static final TextStyle bold32black = TextStyle(
    fontSize: 36.sp,
    fontWeight: FontWeight.w800,
    color: AppColors.blackColor,
  );

  static final TextStyle semibold12White = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.whiteColor,
  );
  static final TextStyle semibold14White = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.whiteColor,
  );
  static final TextStyle semibold16Black = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.hintText2,
  );
  static final TextStyle headingMediumBlack = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.blackColor,
  );
  static final TextStyle bold30Black = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.blackColor,
  )
  ;static final TextStyle bold18black = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.blackColor,
  );
  static final TextStyle bold20black = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
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