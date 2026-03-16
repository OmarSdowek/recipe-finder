import 'package:flutter/material.dart';
import 'package:food_app/core/constant/assets_manger.dart';

import '../widgets/food_card.dart';

class FoodListScreen extends StatelessWidget {
  const FoodListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dishes = [
      {
        "title": "Mediterranean Salmon Bowl",
        "image": AssetsManger.home4,
        "prepTime": 25,
        "isFavorite": true,
      },
      {
        "title": "Artisan Thin Crust Pizza",
        "image": AssetsManger.home4,
        "prepTime": 45,
        "isFavorite": false,
      },
      {
        "title": "Zesty Quinoa Vegan Bowl",
        "image": AssetsManger.home4,
        "prepTime": 15,
        "isFavorite": false,
      },
      {
        "title": "Classic Buttermilk Pancakes",
        "image": AssetsManger.home4,
        "prepTime": 20,
        "isFavorite": true,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Menu"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: dishes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // اتنين جنب بعض
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final dish = dishes[index];
            return FoodCard(
              title: dish["title"] as String,
              imagePath: dish["image"] as String,
              prepTime: dish["prepTime"] as int,
              isFavorite: dish["isFavorite"] as bool,
              onFavoriteToggle: () {
                // هنا تقدر تعمل setState أو bloc event
              },
            );
          },
        ),
      ),
    );
  }
}