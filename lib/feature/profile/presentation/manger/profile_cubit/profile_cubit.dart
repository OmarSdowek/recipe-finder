import 'package:bloc/bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final SupabaseClient _supabase;

  ProfileCubit(this._supabase) : super(ProfileInitial());

  Future<void> updateName(String newName) async {
    emit(ProfileLoading());
    try {
      await _supabase.auth.updateUser(
        UserAttributes(data: {'name': newName}),
      );
      emit(ProfileUpdateSuccess('Name updated successfully'));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> changePassword(String newPassword) async {
    emit(ProfileLoading());
    try {
      await _supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );
      emit(ProfileUpdateSuccess('Password changed successfully'));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
