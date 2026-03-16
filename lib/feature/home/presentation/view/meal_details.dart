import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constant/app_text_style.dart';
import '../manger/home_cubit/meals_cubit.dart';
import '../widgets/meal_header.dart';
import '../widgets/meal_info_section.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments?.toString() ?? '';

    if (mealId.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text("No meal ID provided", style: AppTextStyles.bold18black),
        ),
      );
    }

    return BlocBuilder<MealsCubit, MealsState>(
      builder: (context, state) {
        if (state is MealsLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is MealsError) {
          return Scaffold(
            body: Center(child: Text(state.error)),
          );
        }

        if (state is MealDetailsSuccess) {
          final meal = state.meals.first;

          return Scaffold(
            backgroundColor: const Color(0xffF4F4F4),
            body: Column(
              children: [
                MealHeader(image: meal.strMealThumb),

                Expanded(
                  child: MealInfoSection(meal: meal),
                ),
              ],
            ),
          );
        }

        return const Scaffold();
      },
    );
  }
}