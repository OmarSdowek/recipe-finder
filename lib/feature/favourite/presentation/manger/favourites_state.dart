part of 'favourites_cubit.dart';

abstract class FavouritesState {}

class FavouritesInitial extends FavouritesState {}

class FavouritesLoaded extends FavouritesState {
  final List<Meal> meals;
  FavouritesLoaded(this.meals);
}
