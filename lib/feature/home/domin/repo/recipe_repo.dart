import 'package:dartz/dartz.dart';
import 'package:food_app/core/error/failure.dart';
import '../../data/models/meal_details_model.dart';
import '../../data/models/meal_model.dart';
import '../entity/food_entity.dart';

abstract class RecipeRepository {
  Future<Either<Failure,List<RecipeCategory>>> getCategories();
  Future<Either<Failure,List<Meal>>> getMealsByCategory( String category);
  Future<Either<Failure, List<MealDetailsModel>>> getMealsDetails(String id);}
