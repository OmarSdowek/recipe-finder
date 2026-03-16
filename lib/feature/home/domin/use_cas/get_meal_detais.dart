import 'package:dartz/dartz.dart';
import 'package:food_app/core/error/failure.dart';
import 'package:food_app/core/use_case/use_case.dart';

import '../repo/recipe_repo.dart';

class GetMealDetais extends UseCase{
  final RecipeRepository repository;
  GetMealDetais(this.repository);

  @override
  Future<Either<Failure, dynamic>> call(p) {
    return repository.getMealsDetails(p);

  }


}