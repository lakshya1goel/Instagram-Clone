import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Models/FirebaseHelper.dart';
import 'package:insta_clone/Models/UserModel.dart';
import 'package:insta_clone/Pages/authentication/login/login_page.dart';
import 'package:insta_clone/Pages/authentication/signup/signup_page.dart';
import 'package:insta_clone/Pages/home/chatting_system/chat_contacts.dart';
import 'package:insta_clone/Pages/home/chatting_system/message_screen.dart';
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
import 'package:uuid/uuid.dart';


var uuid=Uuid();

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  User? currentUser=FirebaseAuth.instance.currentUser;
  if(currentUser!=null){
    UserModel? thisUserModel=await FirebaseHelper.getUserModelById(currentUser.uid);
    if(thisUserModel!=null){
      runApp(MyAppLoggedIn(userModel: thisUserModel, firebaseUser: currentUser));
    }
    else{
      runApp(const MyApp());
    }
  }
  else{
    runApp(const MyApp());
  }

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
        "/login": (context) => LoginPage(),
        "/search": (context) => Search(),
        "/profile": (context) => Profile(),
        "/signup_page": (context) => signup_page(),
      },
    );
  }
}

class MyAppLoggedIn extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  MyAppLoggedIn({Key? key, required this.userModel, required this.firebaseUser}) : super(key: key);

  @override
  State<MyAppLoggedIn> createState() => _MyAppLoggedInState();
}

class _MyAppLoggedInState extends State<MyAppLoggedIn> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => Wrapper(userModel: widget.userModel, firebaseUser: widget.firebaseUser),
      },
    );
  }
}
