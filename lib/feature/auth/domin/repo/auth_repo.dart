import 'package:dartz/dartz.dart';
import 'package:food_app/core/error/failure.dart';
import '../entity/user_entity.dart';

abstract class AuthRepo {

 Future<Either<Failure, UserEntity>> signIn({
  required String email,
  required String password,
 });

 Future<Either<Failure, UserEntity>> signUp({
  required String email,
  required String password,
  required String name,
 });

 Future<Either<Failure, void>> logOut();
}