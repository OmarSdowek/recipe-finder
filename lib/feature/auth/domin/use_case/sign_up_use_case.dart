import 'package:dartz/dartz.dart';
import 'package:food_app/core/error/failure.dart';
import 'package:food_app/core/use_case/use_case.dart';
import 'package:food_app/feature/auth/domin/repo/auth_repo.dart';

class SignUpUseCase extends UseCase {
  final AuthRepo authRepo;

  SignUpUseCase(this.authRepo);

  @override
  Future<Either<Failure, void>> call(params) {
    return authRepo.signUp(
      email: params.email,
      password: params.password,
      name: params.name,
    );
  }
}

class SignUpParams {
  final String email;
  final String password;
  final String name;

  SignUpParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
