import 'package:stor_app/auth/domain/models/login_input_model.dart';

abstract class AuthRepository {

  Future<void> login({required LoginInputModel loginInputModel});
}
