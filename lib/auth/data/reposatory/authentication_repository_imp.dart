import 'package:firebase_auth/firebase_auth.dart';
import 'package:stor_app/auth/domain/models/login_input_model.dart';
import 'package:stor_app/auth/domain/reposatory/authentication_reposatory.dart';

class AuthRepositoryImp implements AuthRepository {
  AuthRepositoryImp(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  @override
  Future<void> login({required LoginInputModel loginInputModel}) async {
    await _firebaseAuth
        .signInWithEmailAndPassword(
          email: loginInputModel.email,
          password: loginInputModel.password,
        )
        .catchError(
          (e) => throw FirebaseAuthException(
            code: e.toString(),
            message: e.toString(),
          ),
        );
  }
}
