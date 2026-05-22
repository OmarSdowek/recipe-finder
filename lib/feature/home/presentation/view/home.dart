import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/constant/app_colors.dart';
import 'package:food_app/core/constant/app_text_style.dart';
import 'package:food_app/core/helper/extentions/media_query.dart';
import 'package:food_app/core/widgets/search.dart';
import 'package:food_app/feature/home/domin/entity/food_entity.dart';
import '../manger/home_cubit/meals_cubit.dart';
import '../widgets/category_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final userName = user?.userMetadata?['name'] ?? 'Chef';

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.w(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.h(16)),

              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, $userName 👋",
                        style: AppTextStyles.semibold16Black
                            .copyWith(color: Colors.grey),
                      ),
                      Text(
                        "Recipe Finder",
                        style: AppTextStyles.bold20black,
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.gradientStart.withValues(alpha: 0.15),
                    child: const Icon(
                      Icons.person_outline,
                      color: AppColors.gradientStart,
                    ),
                  ),
                ],
              ),

              SizedBox(height: context.h(20)),

              /// SEARCH FIELD — tapping opens the search delegate
              BlocBuilder<MealsCubit, MealsState>(
                builder: (context, state) {
                  final categories =
                      state is MealsSuccess ? state.meals : <dynamic>[];
                  return GestureDetector(
                    onTap: categories.isNotEmpty
                        ? () => showSearch(
                              context: context,
                              delegate: MealsSearch(
                                categories: categories.cast<RecipeCategory>(),
                              ),
                            )
                        : null,
                    child: AbsorbPointer(
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: categories.isEmpty
                              ? 'Loading categories...'
                              : 'Search categories...',
                          hintStyle:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                          prefixIcon: const Icon(Icons.search,
                              color: Colors.grey),
                          suffixIcon: categories.isNotEmpty
                              ? const Icon(Icons.tune,
                                  color: Colors.grey, size: 20)
                              : null,
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: context.h(25)),

              /// CATEGORY TITLE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Categories", style: AppTextStyles.bold18black),
                  BlocBuilder<MealsCubit, MealsState>(
                    builder: (context, state) {
                      if (state is MealsSuccess) {
                        return Text(
                          "${state.meals.length} total",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),

              SizedBox(height: context.h(20)),

              /// GRID
              Expanded(
                child: BlocBuilder<MealsCubit, MealsState>(
                  builder: (context, state) {
                    if (state is MealsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is MealsSuccess) {
                      return GridView.builder(
                        itemCount: state.meals.length,
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: context.h(16),
                          crossAxisSpacing: context.w(16),
                          childAspectRatio: 0.9,
                        ),
                        itemBuilder: (context, index) {
                          return CategoryItem(
                            category: state.meals[index],
                          );
                        },
                      );
                    }

                    if (state is MealsError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.wifi_off,
                                size: 48, color: Colors.grey),
                            const SizedBox(height: 12),
                            Text(state.error,
                                style: const TextStyle(color: Colors.grey)),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () =>
                                  context.read<MealsCubit>().getCategories(),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
