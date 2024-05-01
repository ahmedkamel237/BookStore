import 'package:flutter/material.dart';
import 'package:stor_app/auth/login/ui/login_page.dart';
import 'package:stor_app/host_page.dart';

class BuilderScreen extends StatelessWidget {
  const BuilderScreen({super.key});
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return const LoginPage();
    return const MainHostPage();
  }
}
