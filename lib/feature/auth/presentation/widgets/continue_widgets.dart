

import 'package:flutter/material.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_style.dart';

Widget CustomContinueWidgets(){
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Divider(color: AppColors.secondaryText,),
        Text("Or continue with",
            style: AppTextStyles.bodyMediumSecondary),
        Divider(color: AppColors.secondaryText),

      ],
    ),
  );
}