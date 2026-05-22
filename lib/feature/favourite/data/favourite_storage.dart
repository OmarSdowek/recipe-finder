import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../home/data/models/meal_model.dart';

class FavouriteStorage {
  static const _storage = FlutterSecureStorage();
  static const _key = 'favourite_meals';

  static Future<List<Meal>> getFavourites() async {
    final raw = await _storage.read(key: _key);
    if (raw == null || raw.isEmpty) return [];
    final List decoded = jsonDecode(raw);
    return decoded.map((e) => Meal.fromJson(e as Map<String, dynamic>)).toList();
  }

  static Future<void> saveFavourites(List<Meal> meals) async {
    final encoded = jsonEncode(
      meals.map((m) => {'idMeal': m.idMeal, 'strMeal': m.strMeal, 'strMealThumb': m.strMealThumb}).toList(),
    );
    await _storage.write(key: _key, value: encoded);
  }
}
