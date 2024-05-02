import 'package:get_it/get_it.dart';
import 'package:stor_app/auth/di/auth_di.dart';

GetIt injector = GetIt.instance;

Future<void> setUpGetIt() async {
  await registerAppDependencies();
}

Future<void> registerAppDependencies() async {
  await AuthDi.initialize();
}
