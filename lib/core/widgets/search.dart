import 'package:flutter/material.dart';
import 'package:food_app/core/constant/app_colors.dart';
import 'package:food_app/core/constant/app_text_style.dart';
import 'package:food_app/core/route/routes.dart';
import '../../feature/home/domin/entity/food_entity.dart';

class MealsSearch extends SearchDelegate<String> {
  final List<RecipeCategory> categories;

  MealsSearch({required this.categories});

  @override
  String get searchFieldLabel => 'Search categories...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryBlue,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white70),
        border: InputBorder.none,
      ),
      textTheme: Theme.of(context).textTheme.copyWith(
            titleLarge: const TextStyle(color: Colors.white, fontSize: 18),
          ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () => query = '',
          icon: const Icon(Icons.close),
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, ''),
      icon: const Icon(Icons.arrow_back),
    );
  }

  List<RecipeCategory> get _filtered => query.isEmpty
      ? categories
      : categories
          .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

  @override
  Widget buildResults(BuildContext context) => _buildList(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildList(context);

  Widget _buildList(BuildContext context) {
    final results = _filtered;

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              'No results for "$query"',
              style: AppTextStyles.semibold16Black
                  .copyWith(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: results.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final category = results[index];
        return ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              category.image,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 56,
                height: 56,
                color: Colors.grey.shade200,
                child: const Icon(Icons.fastfood, color: Colors.grey),
              ),
            ),
          ),
          title: Text(
            category.name,
            style: AppTextStyles.semibold16Black,
          ),
          subtitle: Text(
            category.description.length > 60
                ? '${category.description.substring(0, 60)}...'
                : category.description,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: const Icon(Icons.arrow_forward_ios,
              size: 14, color: Colors.grey),
          onTap: () {
            close(context, category.name);
            Navigator.pushNamed(
              context,
              Routes.mealsByCategory,
              arguments: category.name,
            );
          },
        );
      },
    );
  }
}
