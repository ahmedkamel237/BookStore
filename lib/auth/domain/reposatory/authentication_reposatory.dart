import 'package:stor_app/auth/domain/models/login_input_model.dart';
import 'package:stor_app/auth/domain/models/user_data_model.dart';

abstract class AuthRepository {

  Future<void> login({required LoginInputModel loginInputModel});
   Future<UserDataModel> getUserData();
  Future<void> logout();
}
