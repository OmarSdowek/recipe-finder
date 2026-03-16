import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/route/routes.dart';
import 'package:food_app/feature/home/presentation/manger/home_cubit/meals_cubit.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_style.dart';
import '../widgets/recipe_card.dart';

class MealsByCategory extends StatelessWidget {
  const MealsByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text("$category Recipes", style: AppTextStyles.bold18black),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.gradientStart),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<MealsCubit, MealsState>(
          builder: (context, state) {
            if (state is MealsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MealsError) {
              return Center(child: Text(state.error));
            } else if (state is MealsSuccess) {
              final recipes = state.meals;

              return GridView.builder(
                itemCount: recipes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  return RecipeCard(
                    meal: recipe,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.mealDetail,
                        arguments: recipe.idMeal,
                      );
                    },
                  );
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
