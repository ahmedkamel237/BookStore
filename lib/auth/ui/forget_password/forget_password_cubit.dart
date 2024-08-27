import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor_app/auth/domain/usecases/reset_password_use_case.dart';
import 'package:stor_app/auth/ui/forget_password/forget_password_state.dart';
import 'package:stor_app/common/base/app_injector.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  late final ResetPasswordUseCase _resetPasswordUseCase;

  ForgetPasswordCubit() : super(ForgetPasswordInitial()) {
    _loadUseCase();
  }

  void _loadUseCase() {
    _resetPasswordUseCase = injector();
  }

  Future<void> resetPassword({required String email}) async {
    emit(ForgetPasswordLoading());
    try {
      await _resetPasswordUseCase.execute(email: email);
      emit(ForgetPasswordSuccess());
    } catch (e) {
      emit(ForgetPasswordFailure(e.toString()));
    }
  }
}
