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

//FirebaseAuth.instance.createUserWithEmailAndPassword(
// //     email: email,
// //     password: password,
// //
// //   ).then((value)
// //   {
// //     userCreate(
// //       email: email,
// //       name: name,
// //       phone: phone,
// //       uId: value.user!.uid,
// //     );
// //     emit(SocialRegisterSuccesState());
// //   }).catchError((e)
// //   {
// //     if (e.code == 'weak-password') {
// //       AwesomeDialog(
// //           context: context,
// //           title: "Error",
// //           body: Text("Password is to weak"))
// //         ..show();
// //     } else if (e.code == 'email-already-in-use') {
// //       AwesomeDialog(
// //           context: context,
// //           title: "Error",
// //           body: Text("The account already exists for that email"))
// //         ..show();
// //     }});
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

//  Future<void> logout() async {
//     final connectivityResult = await Connectivity().checkConnectivity();
//
//     // Check for network connectivity
//     if (connectivityResult == ConnectivityResult.none) {
//       // Emit a failure state if no network is found
//       emit(LogoutFailureState("No network connection"));
//       return;
//     }
//
//     try {
//       // Attempt to sign out
//       await _firebaseAuth.signOut();
//
//       // Clear preferences after successful sign out
//       await _prefs.then((value) => value.clear());
//
//       // Emit success state
//       emit(LogoutSuccessState());
//     } catch (e) {
//       // Emit a failure state in case of any error during the sign-out process
//       emit(LogoutFailureState(e.toString()));
//     }
//   }
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
