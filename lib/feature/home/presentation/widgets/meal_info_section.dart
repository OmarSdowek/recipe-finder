import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/widgets/custom_button.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../favourite/presentation/manger/favourites_cubit.dart';
import '../../../home/data/models/meal_details_model.dart';
import '../../../home/data/models/meal_model.dart';
import 'ingredient_section.dart';
import 'instruction_section.dart';

class MealInfoSection extends StatelessWidget {
  final MealDetailsModel meal;

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
          /// CATEGORY & AREA TAGS
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

          /// ADD TO FAVOURITES BUTTON
          BlocBuilder<FavouritesCubit, FavouritesState>(
            builder: (context, state) {
              final isFav = context.read<FavouritesCubit>().isFavourite(meal.idMeal);
              return CustomButton(
                text: isFav ? "Remove from Favourites" : "Add to Favourites",
                onPressed: () {
                  final mealObj = Meal(
                    idMeal: meal.idMeal,
                    strMeal: meal.strMeal,
                    strMealThumb: meal.strMealThumb,
                  );
                  context.read<FavouritesCubit>().toggleFavourite(mealObj);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isFav
                            ? '${meal.strMeal} removed from favourites'
                            : '${meal.strMeal} added to favourites',
                      ),
                      duration: const Duration(seconds: 2),
                      backgroundColor: isFav ? Colors.grey : AppColors.gradientEnd,
                    ),
                  );
                },
                backgroundColor: isFav ? Colors.grey : AppColors.gradientEnd,
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                ),
              );
            },
          ),

          const SizedBox(height: 20),
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
        color: color.withValues(alpha: 0.15),
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
