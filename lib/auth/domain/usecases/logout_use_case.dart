import 'package:stor_app/auth/domain/reposatory/authentication_reposatory.dart';

class LogOutUseCase {
  LogOutUseCase(this._authRepository);
  final AuthRepository _authRepository;
  Future<void> execute() async {
    await _authRepository.logout();
  }
}