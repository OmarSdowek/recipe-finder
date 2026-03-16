import 'package:flutter/material.dart';
import 'package:food_app/core/widgets/custom_button.dart';
import '../../../../core/constant/app_colors.dart';
import 'ingredient_section.dart';
import 'instruction_section.dart';

class MealInfoSection extends StatelessWidget {
  final dynamic meal;

  const MealInfoSection({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: ListView(
        children: [

          /// CATEGORY
          Row(
            children: [
              _Tag(text: meal.strCategory, color: Colors.orange),
              const SizedBox(width: 10),
              _Tag(text: meal.strArea, color: Colors.grey),
            ],
          ),

          const SizedBox(height: 12),

          /// TITLE
          Text(
            meal.strMeal,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 25),

          IngredientsSection(meal: meal),

          const SizedBox(height: 25),

          InstructionsSection(instructions: meal.strInstructions),

          const SizedBox(height: 30),

          CustomButton(
            text: "Add to Favorites",
            onPressed: () {},
            backgroundColor: AppColors.gradientEnd,
            icon: const Icon(Icons.favorite_border, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;
  final Color color;

  const _Tag({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}