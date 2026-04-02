import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domin/use_case/log_in_use_case.dart';
import '../../../domin/use_case/log_out_use_case.dart';
import '../../../domin/use_case/sign_up_use_case.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignUpUseCase signInUseCase;
  final LogInUseCase logInUseCase;
  final LogOutUseCase logOutUseCase;

  AuthCubit({
    required this.signInUseCase,
    required this.logInUseCase,
    required this.logOutUseCase,
  }) : super(AuthInitial());

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    final res = await logInUseCase.call(
      LoginParams(email: email, password: password),
    );

    res.fold((l) => emit(AuthError(l.message)), (r) => emit(AuthSuccess()));
  }

  Future<void> signUp(String email, String password, String name) async {
    emit(AuthLoading());
    final res = await signInUseCase.call(
      SignUpParams(email: email, password: password, name: name),
    );
    res.fold((l) => emit(AuthError(l.message)), (r) => emit(AuthSuccess()));
  }

  Future<void> logOut() async {
    emit(AuthLoading());
    final res = await logOutUseCase.call();
    res.fold((l) => emit(AuthError(l.message)), (r) => emit(AuthSuccess()));
  }
}
