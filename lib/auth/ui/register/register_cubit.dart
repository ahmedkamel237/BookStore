import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor_app/auth/domain/models/register_model_input.dart';
import 'package:stor_app/auth/domain/usecases/register_use_case.dart';
import 'package:stor_app/auth/ui/register/register_state.dart';
import 'package:stor_app/common/base/app_injector.dart';

class RegisterCubit extends Cubit<RegisterState> {
  late final RegisterUseCase _registerUseCase;

  RegisterCubit() : super(RegisterInitial()) {
    _loadUseCases();
  }

  void _loadUseCases() {
    _registerUseCase = injector();
  }

  Future<void> register(
      {required UserRegisterModelInput registerModelInput}) async {
    emit(RegisterLoadingState());
    try {
      await _registerUseCase.execute(registerModelInput: registerModelInput);
      emit(RegisterSuccessState());
    } catch (e) {
      emit(RegisterFailureState(e.toString()));
    }
  }
}
