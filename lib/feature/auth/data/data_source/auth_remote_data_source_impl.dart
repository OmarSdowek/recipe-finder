import 'package:food_app/feature/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_remote_data_sourse.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSourse {

  final SupabaseClient supabase;

  AuthRemoteDataSourceImpl(this.supabase);

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {

    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = response.user;

    if (user == null) {
      throw Exception("Login failed");
    }
    return UserModel(
      id: user.id,
      email: user.email ?? "",
      name: user.userMetadata?["name"] ?? "",
    );  }

  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
  }) async {

    final response = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        "name": name,
      },
    );

    final user = response.user;

    if (user == null) {
      throw Exception("Register failed");
    }

    return UserModel(
      id: user.id,
      email: user.email ?? "",
      name: name,
    );
  }

  @override
  Future<void> logOut() async {
    await supabase.auth.signOut();
  }
}