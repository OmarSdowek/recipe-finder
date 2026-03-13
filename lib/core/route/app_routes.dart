import 'package:flutter/material.dart';
import '../../feature/auth/presentation/view/sign_in.dart';
import '../../feature/auth/presentation/view/sign_up.dart';
import '../../feature/home/domin/entity/food_entity.dart';
import '../../feature/home/presentation/layout.dart';
import '../../feature/splash/presentation/view/splash_screen.dart';
import 'routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) =>  SplashScreen(),
        );

      case Routes.signIn:
        return MaterialPageRoute(
          builder: (_) => const SignIn(),
        );

      case Routes.signUp:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
        );

      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const Layout()
        );

      case Routes.mealsByCategory:
        final category = settings.arguments as RecipeCategory;
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Meals By Category Screen")),
          ),
          settings: RouteSettings(arguments: category),
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