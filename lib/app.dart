import 'package:flutter/material.dart';
import 'package:stor_app/builder_screen.dart';
import 'package:stor_app/common/themes/colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
