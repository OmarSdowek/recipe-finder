import 'package:flutter/material.dart';
import 'package:food_app/feature/auth/domin/repo/auth_repo.dart';
import 'package:food_app/feature/auth/domin/use_case/sign_up_use_case.dart';
import 'package:food_app/feature/home/presentation/view/meal_details.dart';
import '../../feature/auth/data/data_source/auth_remote_data_source_impl.dart';
import '../../feature/auth/data/repo/auth_repo_impl.dart';
import '../../feature/auth/domin/use_case/log_in_use_case.dart';
import '../../feature/auth/domin/use_case/log_out_use_case.dart';
import '../../feature/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import '../../feature/auth/presentation/view/sign_in.dart';
import '../../feature/auth/presentation/view/sign_up.dart';
import '../../feature/home/data/repo/home_repo_implement.dart';
import '../../feature/home/domin/entity/food_entity.dart';
import '../../feature/home/domin/use_cas/get_category_use_case.dart';
import '../../feature/home/domin/use_cas/get_meal_detais.dart';
import '../../feature/home/domin/use_cas/get_meals_by_category_use_cass.dart';
import '../../feature/home/presentation/layout.dart';
import '../../feature/home/presentation/manger/home_cubit/meals_cubit.dart';
import '../../feature/home/presentation/view/meals_by_category.dart';
import '../../feature/splash/presentation/view/splash_screen.dart';
import '../network/api_service.dart';
import 'routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final authRepo = AuthRepoImpl(
      AuthRemoteDataSourceImpl(Supabase.instance.client),
    );
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case Routes.signIn:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => AuthCubit(
              signInUseCase: SignUpUseCase(authRepo),
              logInUseCase: LogInUseCase(authRepo),
              logOutUseCase: LogOutUseCase(authRepo),
            ),
            child: const SignIn(),
          ),
        );

      case Routes.signUp:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => AuthCubit(
              signInUseCase: SignUpUseCase(authRepo),
              logInUseCase: LogInUseCase(authRepo),
              logOutUseCase: LogOutUseCase(authRepo),
            ),
            child: const SignUpScreen(),
          ),
        );

      case Routes.home:
        return MaterialPageRoute(builder: (_) => const Layout());

      case Routes.mealsByCategory:
        final category = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => MealsCubit(
              getCategoriesUseCase: GetCategoriesUseCase(
                HomeRepoImplement(ApiService()),
              ),
              getMealsByCategoryUseCase: GetMealsByCategoryUseCass(
                HomeRepoImplement(ApiService()),
              ),
            )..getMealsByCategory(category),
            child: MealsByCategory(),
          ),
          settings: RouteSettings(arguments: category),
        );

      case Routes.mealDetail:
        final mealId = settings.arguments as String;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => MealsCubit(
              getCategoriesUseCase: GetCategoriesUseCase(
                HomeRepoImplement(ApiService()),
              ),
              getMealsByCategoryUseCase: GetMealsByCategoryUseCass(
                HomeRepoImplement(ApiService()),
              ),
              getMealDetais: GetMealDetais(
                HomeRepoImplement(ApiService()),
              ),
            )..getMealsDetails(mealId),
            child: const MealDetailScreen(),
          ),
          settings: RouteSettings(arguments: mealId),
        );

      case Routes.favourites:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("Favourites Screen"))),
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
