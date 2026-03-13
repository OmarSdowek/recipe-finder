import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/core/constant/app_colors.dart';
import 'package:food_app/core/constant/app_text_style.dart';
import 'package:food_app/core/constant/assets_manger.dart';
import 'package:food_app/core/helper/extentions/media_query.dart';



AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.scaffoldBackground,
    elevation: 0,
    centerTitle: true,
    title: Text("Recipe Finder",
        style: AppTextStyles.bold18black),
    leading: SvgPicture.asset(
      AssetsManger.logo,
      height: context.h(32),
      colorFilter: const ColorFilter.mode(
        AppColors.gradientStart,
        BlendMode.srcIn,
      ),
    ),
  );
}
