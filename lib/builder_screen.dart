import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stor_app/auth/ui/login/login_page.dart';
import 'package:stor_app/host_page.dart';

class BuilderScreen extends StatelessWidget {
   BuilderScreen({super.key});
  static const String routeName = '/';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: _prefs,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final user = snapshot.data?.getString('user');
          if (user != null) {
            return const MainHostPage();
          } else {
            return const LoginPage();
          }
        }
      },
    );
  }
}
