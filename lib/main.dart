import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/app.dart';
import 'package:store_app/common/base/app_injector.dart';
import 'package:store_app/common/helpers/shared_preferances_helper/shared_preferances_helper.dart';
import 'package:store_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await Future.wait([
  //   PushNotificationServices.init(),
  //   LocalNotificationService.init(),
  // ]);
  await setUpGetIt();
  await CacheHelper.init();
  runApp(const MyApp());
}
