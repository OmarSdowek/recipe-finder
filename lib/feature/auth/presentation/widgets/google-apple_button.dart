import 'package:flutter/material.dart';
import 'package:food_app/core/helper/extentions/media_query.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_style.dart';
import '../../../../core/widgets/custom_button.dart';


Widget GooglrAppleButton(BuildContext context){
  return Row(
    children: [
      Expanded(
        child: CustomButton(
          text: "Google",
          onPressed: () {},
          backgroundColor: AppColors.whiteColor,
          isGradient: false,
          textStyle: AppTextStyles.semibold16Black,
        ),
      ),
      context.horizontalSpace(16),
      Expanded(
        child: CustomButton(
          text: "Apple",
          onPressed: () {},
          backgroundColor: AppColors.whiteColor,
          isGradient: false,
          textStyle: AppTextStyles.semibold16Black,
        ),
      ),
    ],
  );
}