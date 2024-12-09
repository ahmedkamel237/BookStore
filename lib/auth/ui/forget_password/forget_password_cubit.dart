import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/auth/domain/usecases/reset_password_use_case.dart';
import 'package:store_app/auth/ui/forget_password/forget_password_state.dart';
import 'package:store_app/common/base/app_injector.dart';
import 'package:store_app/common/utils/network_info.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  late final ResetPasswordUseCase _resetPasswordUseCase;
  late final CheckInternetConnectionUseCase _networkConnectionUseCase;


  ForgetPasswordCubit() : super(ForgetPasswordInitial()) {
    _loadUseCase();
  }

  void _loadUseCase() {
    _resetPasswordUseCase = injector();
    _networkConnectionUseCase = injector();
  }

  Future<void> resetPassword({required String email}) async {
    emit(ForgetPasswordLoading());
    if (!await _networkConnectionUseCase.execute()) {
      emit(ForgetPasswordFailure('No internet connection'));
    }else{
      try {
        await _resetPasswordUseCase.execute(email: email);
        emit(ForgetPasswordSuccess());
      } on FirebaseAuthException catch (e) {
        emit(ForgetPasswordFailure(e.message));
      }
    }
  }
}
