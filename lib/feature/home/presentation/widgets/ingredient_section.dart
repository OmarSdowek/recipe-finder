import 'package:flutter/material.dart';

class IngredientsSection extends StatelessWidget {
  final dynamic meal;

  const IngredientsSection({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Ingredients",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        ...List.generate(meal.ingredients.length, (index) {
          final ing = meal.ingredients[index];
          final meas =
          index < meal.measures.length ? meal.measures[index] : '';

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                const Icon(Icons.check_circle,
                    color: Colors.orange, size: 18),
                const SizedBox(width: 10),
                Expanded(child: Text("$meas $ing")),
              ],
            ),
          );
        }),
      ],
    );
  }
}