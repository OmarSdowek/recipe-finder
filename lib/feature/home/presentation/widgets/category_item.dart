import 'package:flutter/material.dart';
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
      borderRadius: BorderRadius.circular(context.r(12)),
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.mealsByCategory,
          arguments: category.name,
        );
      },
      child: SizedBox(
        width: context.w(155),
        height: context.h(176),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(context.r(12)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                category.image,
                fit: BoxFit.cover,
              ),

              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.5),
                    ],
                  ),
                ),
              ),

              Positioned(
                left: context.w(12),
                bottom: context.h(12),
                right: context.w(12),
                child: Text(
                  category.name.toUpperCase(),
                  style: AppTextStyles.titleMediumWhiteBold.copyWith(
                    shadows: [
                      Shadow(
                        offset: const Offset(0, 1),
                        blurRadius: 2,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}