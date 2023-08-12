import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Pages/authentication/login/login_page.dart';
import 'package:insta_clone/Pages/home/search.dart';
import 'package:insta_clone/Pages/home/profile.dart';
import 'package:insta_clone/Pages/home/wrapper.dart';
import 'package:flutter/services.dart';
import 'package:insta_clone/Pages/authentication/signup/create_account.dart';
import 'package:insta_clone/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  SharedPreferences offlineData = await SharedPreferences.getInstance();
  String uid =  offlineData.getString('uid') ?? "";
  bool isLoggedIn = offlineData.getBool('isLoggedIn') ?? false;
  runApp(MyApp(isLoggedIn: isLoggedIn,uid: uid));
}



class MyApp extends StatelessWidget {
  final String uid;
  final bool isLoggedIn;
  const MyApp({super.key,required this.isLoggedIn,required this.uid});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn ? '/homeProjects/InstagamClone/build/package_info_plus/.transforms/37da98e58b3ab17440533d1d69fd335d/transformed/out/jars/classes.jar!/META-INF/package_info_plus_release.kotlin_module: Module was compiled with an incompatible version of Kotlin. The binary version of its metadata is 1.8.0, expected version is 1.6.0.':'/login',
      routes: {
        "/home" :(context) => Wrapper(),
        "/login": (context) => LoginPage(),
        "/signup": (context) => SignUp(),
        "/search": (context) => Search(),
        "/profile": (context) => Profile(),
      },
    );
  }
}