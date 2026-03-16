import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FoodCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final int prepTime;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const FoodCard({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.prepTime,
    required this.isFavorite,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: SvgPicture.asset(imagePath, fit: BoxFit.cover, height: 150, width: double.infinity),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
                  onPressed: onFavoriteToggle,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                Text("Prep time: $prepTime min", style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}