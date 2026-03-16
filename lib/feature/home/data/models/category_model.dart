import '../../domin/entity/food_entity.dart';

class CategoryModel extends RecipeCategory {

  CategoryModel({
    required super.id,
    required super.name,
    required super.image,
    required super.description,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['idCategory'],
      name: json['strCategory'],
      image: json['strCategoryThumb'],
      description: json['strCategoryDescription'],
    );
  }
}