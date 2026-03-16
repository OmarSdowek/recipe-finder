import 'package:dartz/dartz.dart';
import 'package:food_app/core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../repo/recipe_repo.dart';

class GetMealsByCategoryUseCass extends UseCase {
  final RecipeRepository repository;
  GetMealsByCategoryUseCass(this.repository);

  @override
  Future<Either<Failure, dynamic>> call(p) {
    return repository.getMealsByCategory(p);
  }
}
