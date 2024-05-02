import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor_app/auth/domain/models/login_input_model.dart';
import 'package:stor_app/auth/domain/usecases/login_use_case.dart';
import 'package:stor_app/auth/ui/login/login_state.dart';
import 'package:stor_app/common/base/app_injector.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial()) {
    _loadUseCases();
  }

  late final LoginUseCase _loginUseCase;

  void _loadUseCases() {
    _loginUseCase = injector();
  }

  Future<void> login({required LoginInputModel loginInputModel}) async {
    emit(LoginLoading());
    try {
      await _loginUseCase.execute(loginInputModel: loginInputModel);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(error: e.toString()));
    }
  }
}
