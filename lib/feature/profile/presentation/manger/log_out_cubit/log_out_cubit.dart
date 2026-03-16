import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../auth/domin/use_case/log_out_use_case.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  final LogOutUseCase authRepository;

  LogOutCubit(this.authRepository) : super(LogOutInitial());

  Future<void> logOut() async {
    emit(LogOutLoading());
    final result = await authRepository.call();
    result.fold(
      (failure) => emit(LogOutError(failure.massage)),
      (_) => emit(LogOutSuccess()),
    );
  }

}
