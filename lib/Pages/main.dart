import 'package:flutter/material.dart';
import 'package:insta_clone/Pages/login_page.dart';
import 'package:insta_clone/Utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => LoginPage()
      },
    );
  }
}