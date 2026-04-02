import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../feature/auth/data/data_source/auth_remote_data_source_impl.dart';
import '../../feature/auth/data/repo/auth_repo_impl.dart';
import '../../feature/auth/domin/use_case/sign_up_use_case.dart';
import '../../feature/auth/domin/use_case/log_in_use_case.dart';
import '../../feature/auth/domin/use_case/log_out_use_case.dart';
import '../../feature/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import '../../feature/home/data/repo/home_repo_implement.dart';
import '../../feature/home/domin/use_cas/get_category_use_case.dart';
import '../../feature/home/domin/use_cas/get_meal_detais.dart';
import '../../feature/home/domin/use_cas/get_meals_by_category_use_cass.dart';
import '../../feature/home/presentation/manger/home_cubit/meals_cubit.dart';
import '../network/api_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // ------------------- Auth -------------------
  getIt.registerLazySingleton(() => ApiService());

  getIt.registerLazySingleton(() =>
      AuthRemoteDataSourceImpl(Supabase.instance.client)); // Singleton

  getIt.registerLazySingleton<AuthRepoImpl>(() =>
      AuthRepoImpl(getIt<AuthRemoteDataSourceImpl>()));

  getIt.registerLazySingleton(() => SignUpUseCase(getIt<AuthRepoImpl>()));
  getIt.registerLazySingleton(() => LogInUseCase(getIt<AuthRepoImpl>()));
  getIt.registerLazySingleton(() => LogOutUseCase(getIt<AuthRepoImpl>()));

  getIt.registerFactory(() => AuthCubit(
    signInUseCase: getIt<SignUpUseCase>(),
    logInUseCase: getIt<LogInUseCase>(),
    logOutUseCase: getIt<LogOutUseCase>(),
  ));

  // ------------------- Home -------------------
  getIt.registerLazySingleton(() => HomeRepoImplement(getIt<ApiService>()));
  getIt.registerLazySingleton(() => GetCategoriesUseCase(getIt<HomeRepoImplement>()));
  getIt.registerLazySingleton(() => GetMealsByCategoryUseCass(getIt<HomeRepoImplement>()));
  getIt.registerLazySingleton(() => GetMealDetais(getIt<HomeRepoImplement>()));

  getIt.registerFactory(() => MealsCubit(
    getCategoriesUseCase: getIt<GetCategoriesUseCase>(),
    getMealsByCategoryUseCase: getIt<GetMealsByCategoryUseCass>(),
    getMealDetais: getIt<GetMealDetais>(),
  ));


}