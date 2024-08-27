import 'package:firebase_auth/firebase_auth.dart';
import 'package:stor_app/auth/data/reposatory/authentication_repository_imp.dart';
import 'package:stor_app/auth/domain/reposatory/authentication_reposatory.dart';
import 'package:stor_app/auth/domain/usecases/get_user_data_use_case.dart';
import 'package:stor_app/auth/domain/usecases/login_use_case.dart';
import 'package:stor_app/auth/domain/usecases/logout_use_case.dart';
import 'package:stor_app/auth/domain/usecases/register_use_case.dart';
import 'package:stor_app/auth/domain/usecases/reset_password_use_case.dart';
import 'package:stor_app/common/base/app_injector.dart';

class AuthDi {
  static Future<void> initialize() async {
     final FirebaseAuth auth = FirebaseAuth.instance;
    injector.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImp(injector()),
    );
    injector..registerFactory(() => auth)
    ..registerFactory(() => LoginUseCase(injector()));

    injector
        .registerFactory(() => RegisterUseCase(injector()));

    injector.registerFactory(() => LogOutUseCase(injector()));
    injector.registerFactory(() => GetUserDataUseCase(injector()));
    injector.registerFactory(() => ResetPasswordUseCase(injector()));
  }
}
