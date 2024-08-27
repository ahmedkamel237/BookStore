import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stor_app/auth/domain/models/login_input_model.dart';
import 'package:stor_app/auth/domain/models/register_model_input.dart';
import 'package:stor_app/auth/domain/models/user_data_model.dart';
import 'package:stor_app/auth/domain/reposatory/authentication_reposatory.dart';

class AuthRepositoryImp implements AuthRepository {
  AuthRepositoryImp(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  // todo handel SharedPreferencesHandler
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<void> login(
      {required LoginInputModel loginInputModel}) async {
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

  @override
  Future<void> register(
      {required UserRegisterModelInput registerModelInput}) async {
    await _firebaseAuth
        .createUserWithEmailAndPassword(
      email: registerModelInput.email,
      password: registerModelInput.password,
    )
        .then((value) {
      _firebaseFirestore.collection('users').doc(value.user?.uid).set({
        'email': registerModelInput.email,
        'firstName': registerModelInput.firstName,
        'uId': value.user?.uid,
        'lastName': registerModelInput.lastName,
      }).catchError((error) {
        throw FirebaseAuthException(
          code: error.toString(),
          message: error.toString(),
        );
      });
    });
  }

  @override
  Future<void> resetPassword({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email).catchError((e) {
      throw FirebaseAuthException(
        code: e.toString(),
        message: e.toString(),
      );
    });
  }

  @override
  Future<UserDataModel> getUserData() async {
    final id = _firebaseAuth.currentUser?.uid;
    final userData =
        await _firebaseFirestore.collection('users').doc(id).get().catchError(
              (e) => throw FirebaseAuthException(
                code: e.toString(),
                message: e.toString(),
              ),
        );
    return UserDataModel(
      email: userData['email'] ?? '',
      firstName: userData['firstName'] ?? 'firstName',
      lastName: userData['lastName'] ?? 'lastName',
      id: userData['uId'] ?? 'id',
    );
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
