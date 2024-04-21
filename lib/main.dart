import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stor_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Bookstore(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Bookstore extends StatelessWidget {
  const Bookstore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BookStore")),
      body: const Center(child: Text("Hello World")),
    );
  }
}
