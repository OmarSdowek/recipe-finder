import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/core/constant/app_colors.dart';
import 'package:food_app/core/helper/extentions/media_query.dart';
import 'package:food_app/core/route/routes.dart';
import '../../../../core/constant/app_text_style.dart';
import '../../domin/entity/food_entity.dart';

class CategoryItem extends StatelessWidget {
  final RecipeCategory category;

  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.mealDetail, arguments: category);
      },
      child: SizedBox(
        width: context.w(155),
        height: context.h(176),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(context.r(12)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              SvgPicture.asset(
                category.image,
                fit: BoxFit.cover,
              ),

              Container(
                decoration: BoxDecoration(
                  gradient: AppColors.customGradient
                ),
              ),

              Positioned(
                left: 12,
                bottom: 12,
                child: Text(
                  category.name.toUpperCase(),
                  style: AppTextStyles.titleMediumWhiteBold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}