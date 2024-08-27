import 'package:stor_app/auth/domain/models/login_input_model.dart';
import 'package:stor_app/auth/domain/models/register_model_input.dart';
import 'package:stor_app/auth/domain/models/user_data_model.dart';

abstract class AuthRepository {
  Future<void> login({required LoginInputModel loginInputModel});

  Future<void> register({required UserRegisterModelInput registerModelInput});

  Future<UserDataModel> getUserData();
  Future<void> updateUserData({required UserDataModel userData});
  Future<void> resetPassword({required String email});

  Future<void> logout();
}
