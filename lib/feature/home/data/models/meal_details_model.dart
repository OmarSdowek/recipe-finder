class MealDetailsModel {
  final String idMeal;
  final String strMeal;
  final String strMealAlternate;
  final String strCategory;
  final String strArea;
  final String strInstructions;
  final String strMealThumb;
  final String strTags;
  final String strYoutube;
  final List<String> ingredients;
  final List<String> measures;

  MealDetailsModel({
    required this.idMeal,
    required this.strMeal,
    required this.strMealAlternate,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strMealThumb,
    required this.strTags,
    required this.strYoutube,
    required this.ingredients,
    required this.measures,
  });

  factory MealDetailsModel.fromJson(Map<String, dynamic> json) {
    // جمع المكونات والقياسات
    List<String> ingredients = [];
    List<String> measures = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i']?.toString() ?? '';
      final measure = json['strMeasure$i']?.toString() ?? '';
      if (ingredient.isNotEmpty) ingredients.add(ingredient);
      if (measure.isNotEmpty) measures.add(measure);
    }

    return MealDetailsModel(
      idMeal: json['idMeal']?.toString() ?? '',
      strMeal: json['strMeal']?.toString() ?? 'No Name',
      strMealAlternate: json['strMealAlternate']?.toString() ?? '',
      strCategory: json['strCategory']?.toString() ?? 'Unknown',
      strArea: json['strArea']?.toString() ?? 'Unknown',
      strInstructions: json['strInstructions']?.toString() ?? 'No instructions',
      strMealThumb: json['strMealThumb']?.toString() ??
          'https://via.placeholder.com/150',
      strTags: json['strTags']?.toString() ?? '',
      strYoutube: json['strYoutube']?.toString() ?? '',
      ingredients: ingredients,
      measures: measures,
    );
  }
}