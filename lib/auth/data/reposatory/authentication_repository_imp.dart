import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stor_app/auth/domain/models/login_input_model.dart';
import 'package:stor_app/auth/domain/models/user_data_model.dart';
import 'package:stor_app/auth/domain/reposatory/authentication_reposatory.dart';

class AuthRepositoryImp implements AuthRepository {
  AuthRepositoryImp(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;
  // todo handel SharedPreferencesHandler
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


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
    final user = _firebaseAuth.currentUser?.email;
    if (user != null) {
      await _prefs.then((value) => value.setString('user', user));
    }
  }


  // @override
  // Future<void> register({required LoginInputModel loginInputModel}) async {
  //   await _firebaseAuth
  //       .createUserWithEmailAndPassword(
  //         email: loginInputModel.email,
  //         password: loginInputModel.password,
  //       )
  //       .catchError(
  //         (e) => throw FirebaseAuthException(
  //           code: e.toString(),
  //           message: e.toString(),
  //         ),
  //       );
  //   final user = _firebaseAuth.currentUser?.email;
  //   if (user != null) {
  //     await _prefs.then((value) => value.setString('user', user));
  //   }
  // }

  @override
  Future<UserDataModel> getUserData() async {
    // final user = _firebaseAuth.currentUser?.email;
    // print('user: $user');
    // if (user != null) {
      return const UserDataModel(
        email: "ahmed@gmail.com",
        firstName: 'Ahmed',
        lastName: 'Mahmoud',
      );
    // }else {
    // throw Exception('user not found');
    // }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut().catchError(
      (e) => throw FirebaseAuthException(
        code: e.toString(),
        message: e.toString(),
      ),
    );
    await _prefs.then((value) => value.clear());
  }
}
