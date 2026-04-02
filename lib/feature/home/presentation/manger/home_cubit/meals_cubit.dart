import 'package:bloc/bloc.dart';
import 'package:food_app/feature/home/data/models/meal_details_model.dart';
import 'package:meta/meta.dart';
import '../../../domin/entity/food_entity.dart';
import '../../../domin/use_cas/get_category_use_case.dart';
import '../../../domin/use_cas/get_meal_detais.dart';
import '../../../domin/use_cas/get_meals_by_category_use_cass.dart';

part 'meals_state.dart';

class MealsCubit extends Cubit<MealsState> {
  final GetMealsByCategoryUseCass getMealsByCategoryUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetMealDetais? getMealDetais;


  MealsCubit({
    required this.getMealsByCategoryUseCase,
    required this.getCategoriesUseCase,
    this.getMealDetais
  }) : super(MealsInitial());

  Future<void> getCategories() async {
    emit(MealsLoading());
    final result = await getCategoriesUseCase.call();
    result.fold(
      (l) => emit(MealsError(l.message)),
      (r) => emit(MealsSuccess(meals: r)),
    );
  }


  Future<void> getMealsByCategory(String category) async {
    emit(MealsLoading());
    final result = await getMealsByCategoryUseCase.call(category);
    result.fold(
          (l) => emit(MealsError(l.message)),
          (r) => emit(MealsSuccess(meals: r)),
    );
  }

  Future<void> getMealsDetails(String id) async {
    emit(MealsLoading());

    final result = await getMealDetais?.call(id);

    result?.fold(
          (l) => emit(MealsError(l.message)),
          (r) => emit(MealDetailsSuccess(meals: r)),
    );
  }
}
