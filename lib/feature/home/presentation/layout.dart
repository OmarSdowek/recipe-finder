import 'package:flutter/material.dart';
import 'package:food_app/feature/home/presentation/view/home.dart';
import 'package:food_app/feature/home/presentation/widgets/custom_nav_bar.dart';


class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Home(),
    const Center(child: Text("Favorites Screen")),
    const Center(child: Text("Profile Screen")),
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
