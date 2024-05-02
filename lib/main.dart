import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stor_app/app.dart';
import 'package:stor_app/common/base/app_injector.dart';
import 'package:stor_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setUpGetIt();
  runApp(const MyApp());
}
