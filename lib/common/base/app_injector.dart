import 'package:get_it/get_it.dart';
import 'package:stor_app/admin/di/admin_di.dart';
import 'package:stor_app/auth/di/auth_di.dart';
import 'package:stor_app/di/common_di.dart';
import 'package:stor_app/home/di/home_di.dart';

GetIt injector = GetIt.instance;

Future<void> setUpGetIt() async {
  await registerAppDependencies();
}

Future<void> registerAppDependencies() async {
  await AuthDi.initialize();
  await AdminDi.initialize();
  await HomeDi.initialize();
  await CommonDi.initialize();
}
