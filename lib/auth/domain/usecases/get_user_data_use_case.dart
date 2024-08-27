import 'package:stor_app/auth/domain/models/user_data_model.dart';
import 'package:stor_app/auth/domain/reposatory/authentication_reposatory.dart';

class GetUserDataUseCase {
  GetUserDataUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<UserDataModel> execute() async {
    return await _authRepository.getUserData();
  }
}
