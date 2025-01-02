import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:store_app/app.dart';
import 'package:store_app/common/base/app_injector.dart';
import 'package:store_app/common/helpers/shared_preferances_helper/shared_preferances_helper.dart';
import 'package:store_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  // await Future.wait([
  //   PushNotificationServices.init(),
  //   LocalNotificationService.init(),
  // ]);
  await setUpGetIt();
  await CacheHelper.init();
  runApp(const MyApp());
}
