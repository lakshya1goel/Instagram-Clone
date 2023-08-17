import 'package:flutter/material.dart';
import 'package:insta_clone/Models/UserModel.dart';
import 'package:insta_clone/Pages/authentication/signup/signup_page.dart';
import 'package:insta_clone/Pages/home/homepage.dart';
import 'package:insta_clone/Pages/home/wrapper.dart';
import 'package:insta_clone/Pages/authentication/signup/create_account.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username="";
  String password="";
  bool _obscureText=true;
  int selectedIndex=0;
  String language = "English (US)";
  List<String> lang=[
    'English (US)', 'Afrikaans', 'Bahasa Indonesia', 'Bahasa Melayu', 'Dansk', 'Deutsch', 'English (UK)', 'Filipino', 'Hrvatski'
  ];


  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();

  void checkValues(){
    String email=emailController.text.trim();
    String password=passwordController.text.trim();

    if(email=="" || password==""){
      print("Please fill all the fields!");
    }
    else{
      print("SignUp Successfull!");
      login(email, password);
    }
  }


  void login(String email, String password) async{
    UserCredential? credential;
    try{
      credential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(ex){
      print(ex.code.toString());
    }

    if(credential!=null){
      String uid=credential.user!.uid;
      DocumentSnapshot userData= await FirebaseFirestore.instance.collection("users").doc(uid).get();
      UserModel userModel=UserModel.fromMap(userData.data() as Map<String, dynamic>);

      print("Login successful!");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Wrapper()));
    }


  }




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: TextButton(
                    onPressed: (){
                      _bottomSheet(context);
                    },
                    child: Text(
                        language,
                      style: TextStyle(
                        color: Colors.grey
                      ),
                    ),
                  )
                ),
                SizedBox(height: 60),
                _centerWidget(),
                SizedBox(height: 60),
                _bottomWidget()
              ],
            ) ,
          ),
        ),
      ),
    );
  }

  void _bottomSheet(context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext icon) {
        return LanguageSelectionWidget(
          lang: lang,
          selectedIndex: lang.indexOf(language),
          onChanged: (int? index) {
            setState(() {
              language = lang[index!];
              Navigator.pop(context);
            });
          },
        );
      },
    );
  }


  Widget _centerWidget(){
    return Column(
      children: [
        Center(
          child: Image.asset("assets/images/authentication/insta_icon.jpg",
            height: 100,
            width: 100,
          ),
        ),
      ],
    );
  }


  Widget _bottomWidget() {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email Address",
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)
                ),
              ),
              onChanged: (value) {
                username = value;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  suffixIcon: GestureDetector(
                    onTap: (){
                      setState(() {
                        _obscureText= !_obscureText;
                      }
                      );
                    },
                    child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility,),
                  ),
                ),
                onChanged: (value) {
                  password = value;
                },
              ),
            ),
            SizedBox(
              width: 500.0,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ))
                ),
                onPressed: () {
                  checkValues();
                },
                child: const Text(
                  'Log in',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: GestureDetector(
                  onTap: () {

                  },
                  child: Text("Forgotten Password?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ),
            ),
            SizedBox(
              height: 150.0,
            ),
            SizedBox(
              width: 500.0,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.white),
                  side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(width: 2.0, color: Colors.blue),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      )),
                  elevation: MaterialStateProperty.all<double>(0.0),
                ),
                onPressed: () {

                },
                child: TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => signup_page()));
                  },
                  child: Text("Create new account",
                    style: TextStyle(
                      color: Colors.blue,
                    ),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class LanguageSelectionWidget extends StatelessWidget {
  final List<String> lang;
  final int selectedIndex;
  final Function(int?)? onChanged;

  LanguageSelectionWidget({
    required this.lang,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 500.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Select your language",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: lang.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(lang[index]),
                        trailing: Radio(
                          value: index,
                          groupValue: selectedIndex,
                          onChanged: onChanged,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

