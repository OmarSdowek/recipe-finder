import 'package:dartz/dartz.dart';
import 'package:food_app/core/error/failure.dart';
import 'package:food_app/feature/auth/domin/entity/user_entity.dart';
import 'package:food_app/feature/auth/domin/repo/auth_repo.dart';
import '../data_source/auth_remote_data_sourse.dart';

class AuthRepoImpl implements AuthRepo {

  final AuthRemoteDataSourse authRemoteDataSourse;

  AuthRepoImpl(this.authRemoteDataSourse);

  @override
  Future<Either<Failure, void>> logOut() async {

    try {

      await authRemoteDataSourse.logOut();

      return const Right(null);

    } catch (e) {

      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  }) async {

    try {

      final res = await authRemoteDataSourse.signIn(
        email: email,
        password: password,
      );

      return Right(res);

    } catch (e) {

      return Left(Failure(e.toString()));

    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {

    try {

      final res = await authRemoteDataSourse.signUp(
        email: email,
        password: password,
        name: name,
      );

      return Right(res);

    } catch (e) {

      return Left(Failure(e.toString()));

    }
  }
}