import 'package:store_app/auth/domain/reposatory/authentication_reposatory.dart';

class ResetPasswordUseCase {
  final AuthRepository _authRepository;

  ResetPasswordUseCase(
    this._authRepository,
  );

  Future<void> execute({required String email}) async {
    await _authRepository.resetPassword(email: email);
  }
}
