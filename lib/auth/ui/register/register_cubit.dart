import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/auth/domain/models/register_model_input.dart';
import 'package:store_app/auth/domain/usecases/register_use_case.dart';
import 'package:store_app/auth/ui/register/register_state.dart';
import 'package:store_app/common/base/app_injector.dart';
import 'package:store_app/common/utils/network_info.dart';

class RegisterCubit extends Cubit<RegisterState> {
  late final RegisterUseCase _registerUseCase;
  late final CheckInternetConnectionUseCase _networkConnectionUseCase;

  RegisterCubit() : super(RegisterInitial()) {
    _loadUseCases();
  }

  void _loadUseCases() {
    _registerUseCase = injector();
    _networkConnectionUseCase = injector();
  }

  Future<void> register(
      {required UserRegisterModelInput registerModelInput}) async {
    emit(RegisterLoadingState());
    if (!await _networkConnectionUseCase.execute()) {
      emit(RegisterFailureState('No internet connection'));
    }else{
      try {
        await _registerUseCase.execute(registerModelInput: registerModelInput);
        emit(RegisterSuccessState());
      } on FirebaseAuthException catch (e) {
        emit(RegisterFailureState(e.message));
      }
    }

  }
}
