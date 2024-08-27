import 'package:stor_app/auth/domain/models/user_data_model.dart';
import 'package:stor_app/auth/domain/reposatory/authentication_reposatory.dart';

class UpdateUserDataUseCase {
  UpdateUserDataUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<void> execute({required UserDataModel userData}) async {
    await _authRepository.updateUserData(userData: userData);
  }
}
