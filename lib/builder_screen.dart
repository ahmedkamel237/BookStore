import 'package:flutter/material.dart';
import 'package:store_app/auth/ui/login/login_page.dart';
import 'package:store_app/common/helpers/shared_preferances_helper/shared_preferances_helper.dart';
import 'package:store_app/host_page.dart';
import 'package:store_app/test_theme.dart';

class BuilderScreen extends StatelessWidget {
  const BuilderScreen({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    // return DemoScreen();
    final user = CacheHelper.getData(key: 'user');
    if (user != null) {
      return const MainHostPage();
    } else {
      return const LoginPage();
    }
  }
}
