import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:insta_clone/Pages/authentication/login/login_page.dart';
import 'package:insta_clone/Pages/authentication/signup/dob_page.dart';
import 'package:insta_clone/Pages/authentication/signup/mobile_number.dart';
import 'package:insta_clone/Pages/authentication/signup/save_login_info.dart';
import 'package:insta_clone/Pages/home/home_page.dart';
import 'package:insta_clone/Utils/routes.dart';
import 'package:insta_clone/Pages/authentication/signup/create_account.dart';
import 'package:insta_clone/Pages/authentication/signup/password.dart';

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
        "/login": (context) => LoginPage(),
        "/signup": (context) => SignUp(),
        "/password": (context) => PassWord(),
        "/home" :(context) => HomePage(),
        "/saveinfo": (context) => SaveInfo(),
        "/dob": (context) => DobPage(),
        "/username": (context) => DobPage(),
        "/mobile": (context) => MobileNumber(),
      },
    );
  }
}