import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Pages/authentication/login/login_page.dart';
import 'package:insta_clone/Pages/home/chatting_system/chat_contacts.dart';
import 'package:insta_clone/Pages/home/search.dart';
import 'package:insta_clone/Pages/authentication/signup/username.dart';
import 'package:insta_clone/Pages/home/profile.dart';
import 'package:insta_clone/Pages/home/wrapper.dart';
import 'package:flutter/services.dart';
import 'package:insta_clone/Pages/authentication/signup/dob_page.dart';
import 'package:insta_clone/Pages/authentication/signup/mobile_number.dart';
import 'package:insta_clone/Pages/authentication/signup/save_login_info.dart';
import 'package:insta_clone/Pages/authentication/signup/create_account.dart';
import 'package:insta_clone/Pages/authentication/signup/password.dart';
import 'package:insta_clone/firebase_options.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
        "/home" :(context) => Wrapper(),
        "/login": (context) => LoginPage(),
        "/signup": (context) => SignUp(),
        "/password": (context) => PassWord(),
        "/saveinfo": (context) => SaveInfo(),
        "/dob": (context) => DobPage(),
        "/username": (context) => UserName(),
        "/mobile": (context) => MobileNumber(),
        "/search": (context) => Search(),
        "/profile": (context) => Profile(),
        "/chat_contact": (context) => ChatContact(),
      },
    );
  }
}