import 'package:dartz/dartz.dart';
import 'package:dio/src/response.dart';
import 'package:food_app/core/error/failure.dart';
import 'package:food_app/feature/home/data/models/meal_details_model.dart';
import 'package:food_app/feature/home/domin/entity/food_entity.dart';
import 'package:food_app/feature/home/domin/repo/recipe_repo.dart';
import '../../../../core/constant/api_endpoint.dart';
import '../../../../core/network/api_service.dart';
import '../models/category_model.dart';
import '../models/meal_model.dart';

class HomeRepoImplement implements RecipeRepository{
  final ApiService _apiService;
  HomeRepoImplement(this._apiService);

  @override
  Future<Either<Failure, List<RecipeCategory>>> getCategories() async {

    try {

      final Response response = await _apiService.get(ApiEndpoints.categories);

      List categories = response.data['categories'];

      List<RecipeCategory> categoryList =
      categories.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>)).toList();

      return Right(categoryList);

    } catch (e) {

      return Left(Failure(e.toString()));

    }

  }

  @override
  Future<Either<Failure, List<Meal>>> getMealsByCategory(String category) async{
    try {
      final endPoint = "${ApiEndpoints.baseUrl}/filter.php?c=$category";
      final Response response = await _apiService.get(endPoint);

      List categories = response.data['meals'];

      List<Meal> mealList =
      categories.map((e) => Meal.fromJson(e as Map<String, dynamic>)).toList();

      return Right(mealList);

    } catch (e) {

      return Left(Failure(e.toString()));

    }
  }


  Future<Either<Failure, List<MealDetailsModel>>> getMealsDetails(String id) async {
    try {
      final String endPoint = "${ApiEndpoints.baseUrl}/lookup.php?i=$id";
      final Response response = await _apiService.get(endPoint);

      final List? meals = response.data['meals'];

      if (meals == null || meals.isEmpty) {
        return Left(Failure("No meal found for ID: $id"));
      }

      List<MealDetailsModel> mealList =
      meals.map((e) => MealDetailsModel.fromJson(e as Map<String, dynamic>)).toList();

      return Right(mealList);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

}