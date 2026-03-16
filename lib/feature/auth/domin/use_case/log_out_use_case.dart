import 'package:dartz/dartz.dart';
import 'package:food_app/core/error/failure.dart';
import 'package:food_app/core/use_case/no_param_use_case.dart';
import '../repo/auth_repo.dart';

class LogOutUseCase extends UseCase{
  final AuthRepo authRepo;

  LogOutUseCase(this.authRepo);

  @override
  Future<Either<Failure, dynamic>> call() {
    return authRepo.logOut();
  }

}