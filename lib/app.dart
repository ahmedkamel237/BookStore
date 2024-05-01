import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stor_app/builder_screen.dart';
import 'package:stor_app/packeges/utils/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: AppColor.primary8,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: AppColor.primary7,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColor.primary8,
            elevation: 0,
          ),
        ),
        home: const BuilderScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
