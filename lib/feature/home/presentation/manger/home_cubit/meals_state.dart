part of 'meals_cubit.dart';

@immutable
sealed class MealsState {}

final class MealsInitial extends MealsState {}

final class MealsLoading extends MealsState {}

final class MealsSuccess extends MealsState {
  final List meals;
  MealsSuccess({required this.meals});
}

final class MealDetailsSuccess extends MealsState {
  final List<MealDetailsModel> meals;
  MealDetailsSuccess({required this.meals});
}


final class MealsError extends MealsState {
  final String error;
  MealsError(this.error);
}
