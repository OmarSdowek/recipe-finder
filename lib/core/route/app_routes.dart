import 'package:flutter/material.dart';
import 'package:food_app/feature/home/presentation/view/meal_details.dart';
import '../../feature/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import '../../feature/auth/presentation/view/sign_in.dart';
import '../../feature/auth/presentation/view/sign_up.dart';
import '../../feature/favourite/presentation/manger/favourites_cubit.dart';
import '../../feature/home/presentation/layout.dart';
import '../../feature/home/presentation/manger/home_cubit/meals_cubit.dart';
import '../../feature/home/presentation/view/meals_by_category.dart';
import '../../feature/splash/presentation/view/splash_screen.dart';
import '../di/locator.dart';
import 'routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.signIn:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<AuthCubit>(),
            child: const SignIn(),
          ),
        );

      case Routes.signUp:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<AuthCubit>(),
            child: const SignUpScreen(),
          ),
        );

      case Routes.home:
        return MaterialPageRoute(builder: (_) => const Layout());

      case Routes.mealsByCategory:
        final category = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) {
            final cubit = getIt<MealsCubit>();
            cubit.getMealsByCategory(category);
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: cubit),
                BlocProvider.value(value: getIt<FavouritesCubit>()),
              ],
              child: const MealsByCategory(),
            );
          },
          settings: RouteSettings(arguments: category),
        );

      case Routes.mealDetail:
        final mealId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) {
            final cubit = getIt<MealsCubit>();
            cubit.getMealsDetails(mealId);
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: cubit),
                BlocProvider.value(value: getIt<FavouritesCubit>()),
              ],
              child: const MealDetailScreen(),
            );
          },
          settings: RouteSettings(arguments: mealId),
        );

      case Routes.favourites:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<FavouritesCubit>(),
            child: const Scaffold(body: Center(child: Text("Favourites Screen"))),
          ),
        );

      case Routes.profile:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("Profile Screen"))),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("No Route Found"))),
        );
    }
  }
}
