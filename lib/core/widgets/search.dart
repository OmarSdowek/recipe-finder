import 'package:flutter/material.dart';
import '../../feature/home/presentation/widgets/category_item.dart';
import '../../../../core/constant/app_colors.dart';

class MealsSearch extends SearchDelegate {
  final List categories;

  MealsSearch({required this.categories});

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryBlue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white70),
        border: InputBorder.none,
      ),
      textTheme: theme.textTheme.copyWith(
        titleLarge: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.cancel),
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context); // استخدم نفس الفلترة للنتائج النهائية
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filterData = query.isEmpty
        ? categories
        : categories
        .where((element) => element.strCategory
        .toLowerCase()
        .contains(query.toLowerCase()))
        .toList();

    if (filterData.isEmpty) {
      return const Center(child: Text('No matching categories'));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: filterData.length,
        itemBuilder: (context, index) {
          final category = filterData[index];
          return CategoryItem(category: category);
        },
      ),
    );
  }
}