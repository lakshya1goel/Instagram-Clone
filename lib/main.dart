import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:insta_clone/Pages/authentication/login/login_page.dart';
import 'package:insta_clone/Pages/home/home_page.dart';
import 'package:insta_clone/Utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
        "/home" :(context) => HomePage(),
      },
    );
  }
}