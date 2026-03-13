import 'package:dartz/dartz.dart';
import 'package:food_app/core/error/failure.dart';

import '../entity/food_entity.dart';

abstract class RecipeRepository {
  Future<Either<Failure,List<RecipeCategory>>> getCategories();
}
