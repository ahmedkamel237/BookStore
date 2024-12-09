import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/auth/domain/models/login_input_model.dart';
import 'package:store_app/auth/domain/usecases/login_use_case.dart';
import 'package:store_app/auth/ui/login/login_state.dart';
import 'package:store_app/common/base/app_injector.dart';
import 'package:store_app/common/utils/network_info.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial()) {
    _loadUseCases();
  }

  late final LoginUseCase _loginUseCase;
  late final CheckInternetConnectionUseCase _networkConnectionUseCase;

  void _loadUseCases() {
    _loginUseCase = injector();
    _networkConnectionUseCase = injector();
  }

  Future<void> login({required LoginInputModel loginInputModel}) async {
    emit(LoginLoading());
    if (!await _networkConnectionUseCase.execute()) {
      emit(LoginFailure(error: 'No internet connection'));
    } else {
      try {
        await _loginUseCase.execute(loginInputModel: loginInputModel);
        emit(LoginSuccess());
      } on FirebaseAuthException catch (e) {
        emit(LoginFailure(error: e.message ?? ''));
      }
    }
  }
}
