import 'package:dartz/dartz.dart';
import 'package:food_app/core/error/failure.dart';
import 'package:food_app/core/use_case/no_param_use_case.dart';
import 'package:food_app/feature/home/domin/entity/food_entity.dart';

import '../repo/recipe_repo.dart';

class GetCategoriesUseCase extends UseCase{
  final RecipeRepository repository;
  GetCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<RecipeCategory>>> call() {
   return repository.getCategories();
  }


}