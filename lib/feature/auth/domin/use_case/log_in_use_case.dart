import 'package:dartz/dartz.dart';
import 'package:food_app/core/error/failure.dart';
import 'package:food_app/core/use_case/use_case.dart';
import 'package:food_app/feature/auth/domin/repo/auth_repo.dart';

class LogInUseCase extends UseCase{
  final AuthRepo authRepo;

  LogInUseCase(this.authRepo);

  @override
  Future<Either<Failure, void>> call(params) {
    return authRepo.signIn(email: params.email, password: params.password);
  }

}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}