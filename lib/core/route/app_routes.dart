import 'package:flutter/material.dart';
import 'routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Splash Screen")),
          ),
        );

      case Routes.signIn:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Sign In Screen")),
          ),
        );

      case Routes.signUp:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Sign Up Screen")),
          ),
        );

      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Home Screen")),
          ),
        );

      case Routes.mealsByCategory:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Meals By Category Screen")),
          ),
        );

      case Routes.mealDetail:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Meal Detail Screen")),
          ),
        );

      case Routes.favourites:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Favourites Screen")),
          ),
        );

      case Routes.profile:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Profile Screen")),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("No Route Found")),
          ),
        );
    }
  }
}