import 'package:firebase_auth/firebase_auth.dart';
import 'package:stor_app/auth/data/reposatory/authintacation_repository_imp.dart';
import 'package:stor_app/auth/domain/reposatory/authintacation_reposatory.dart';
import 'package:stor_app/auth/domain/usecases/login_use_case.dart';
import 'package:stor_app/common/base/app_injector.dart';

class AuthDi {
  static Future<void> initialize() async {
     final FirebaseAuth auth = FirebaseAuth.instance;
    injector.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImp(injector()),
    );
    injector..registerFactory(() => auth)
    ..registerFactory(() => LoginUseCase(injector()));
  }
}
