import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/constant/app_colors.dart';
import 'package:food_app/core/constant/app_text_style.dart';
import 'package:food_app/core/helper/extentions/media_query.dart';
import '../../../../core/widgets/custom_text_form_feild.dart';
import '../../../../core/widgets/search.dart';
import '../manger/home_cubit/meals_cubit.dart';
import '../widgets/category_item.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.w(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recipe Finder",
                    style: AppTextStyles.bold20black,
                  ),
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.red),
                    onPressed: () {
                      final state = context.read<MealsCubit>().state;
                      if (state is MealsSuccess) {
                        showSearch(
                          context: context,
                          delegate: MealsSearch(categories: state.meals),
                        );
                      }
                    },
                  ),
                ],
              ),

              context.verticalSpace(20),

              /// SEARCH
              CustomTextFormField(
                hintText: "Search recipes, ingredients...",
                prefixIcon: const Icon(Icons.search),
                width: double.infinity,
                height: context.h(56),
                keyboardType: TextInputType.text,
                backgroundColor: AppColors.hintText,
              ),

              SizedBox(height: context.h(25)),

              /// CATEGORY TITLE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: AppTextStyles.bold18black,
                  ),
                  const Text(
                    "See All",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              SizedBox(height: context.h(20)),

              /// GRID
              Expanded(
                child: BlocBuilder<MealsCubit, MealsState>(
                  builder: (context, state) {

                    if (state is MealsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is MealsSuccess) {

                      final categories = state.meals;

                      return GridView.builder(
                        itemCount: categories.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: context.h(16),
                          crossAxisSpacing: context.w(16),
                          childAspectRatio: 0.9,
                        ),
                        itemBuilder: (context, index) {
                          return CategoryItem(
                            category: categories[index],
                          );
                        },
                      );
                    }

                    if (state is MealsError) {
                      return Center(
                        child: Text(state.error),
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