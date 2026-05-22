import 'package:bloc/bloc.dart';
import 'package:food_app/feature/favourite/data/favourite_storage.dart';
import '../../../home/data/models/meal_model.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit() : super(FavouritesInitial());

  List<Meal> _favourites = [];

  List<Meal> get favourites => List.unmodifiable(_favourites);

  Future<void> loadFavourites() async {
    _favourites = await FavouriteStorage.getFavourites();
    emit(FavouritesLoaded(List.unmodifiable(_favourites)));
  }

  Future<void> toggleFavourite(Meal meal) async {
    final exists = _favourites.any((m) => m.idMeal == meal.idMeal);
    if (exists) {
      _favourites.removeWhere((m) => m.idMeal == meal.idMeal);
    } else {
      _favourites.add(meal);
    }
    await FavouriteStorage.saveFavourites(_favourites);
    emit(FavouritesLoaded(List.unmodifiable(_favourites)));
  }

  bool isFavourite(String mealId) {
    return _favourites.any((m) => m.idMeal == mealId);
  }
}
