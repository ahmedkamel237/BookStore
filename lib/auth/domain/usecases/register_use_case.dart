import 'package:stor_app/auth/domain/models/register_model_input.dart';
import 'package:stor_app/auth/domain/reposatory/authentication_reposatory.dart';

class RegisterUseCase {
  RegisterUseCase(this._authRepository);
  final AuthRepository _authRepository;
  Future<void> execute({required UserRegisterModelInput registerModelInput}) async {
    await _authRepository.register(registerModelInput: registerModelInput);
  }
}