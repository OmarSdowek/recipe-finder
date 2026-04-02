import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/feature/home/presentation/view/home.dart';
import 'package:food_app/feature/home/presentation/widgets/custom_nav_bar.dart';
import '../../../core/di/locator.dart';
import '../../favourite/presentation/view/favourite_screen.dart';
import '../../profile/presentation/views/profile_screen.dart';
import 'manger/home_cubit/meals_cubit.dart';


class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    BlocProvider(
      create: (BuildContext context) {
        final cubit = getIt<MealsCubit>();
        cubit.getCategories();
        return cubit;
      },
      child: const Home(),
    ),
    FoodListScreen(),
    ProfileSettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
