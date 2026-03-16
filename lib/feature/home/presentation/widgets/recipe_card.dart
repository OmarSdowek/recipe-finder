import 'package:flutter/material.dart';
import 'package:food_app/core/constant/app_text_style.dart';
import 'package:food_app/core/helper/extentions/media_query.dart';
import '../../data/models/meal_model.dart';

class RecipeCard extends StatelessWidget {
  final Meal meal;
  final void Function()? onTap;

  const RecipeCard({super.key, required this.meal,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.r(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(context.r(12)),
              ),
              child: Image.network(
                meal.strMealThumb,
                height: context.h(120),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  Text(
                    meal.strMeal,
                    style: AppTextStyles.semibold16Black,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: context.h(8)),

                  /// ID or Time
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 16, color: Colors.grey),
                      SizedBox(width: context.w(5)),
                      Text(
                        "25 : 30",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}