import 'package:firebase_auth/firebase_auth.dart';
import 'package:stor_app/auth/domain/models/login_input_model.dart';
import 'package:stor_app/auth/domain/reposatory/authintacation_reposatory.dart';

class AuthRepositoryImp implements AuthRepository {
  AuthRepositoryImp(this._firebaseAuth);

   final FirebaseAuth _firebaseAuth;

  @override
  Future<void> login({required LoginInputModel loginInputModel}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: loginInputModel.email,
        password: loginInputModel.password,
      );
    } on Exception catch (error) {
      print('Error signing in: $error');
    }
  }
}
