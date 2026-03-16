import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../model/user_model.dart';

abstract class AuthRemoteDataSourse {

  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
  });

  Future<void> logOut();
}