import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:store_app/builder_screen.dart';
import 'package:store_app/packeges/utils/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              surfaceTint: AppColors.primary8,//to change when Scroll color
            ),
            scaffoldBackgroundColor: AppColors.primary8,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: AppColors.primary7,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.primary8,
              elevation: 0,
            ),
          ),
          home: const BuilderScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
