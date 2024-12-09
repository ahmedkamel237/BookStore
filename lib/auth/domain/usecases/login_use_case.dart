import 'package:store_app/auth/domain/models/login_input_model.dart';
import 'package:store_app/auth/domain/reposatory/authentication_reposatory.dart';

class LoginUseCase {
  LoginUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<void> execute({required LoginInputModel loginInputModel}) async {
    await _authRepository.login(loginInputModel: loginInputModel);
  }
}
