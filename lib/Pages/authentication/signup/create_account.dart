import 'package:flutter/material.dart';
import 'package:insta_clone/Models/user_model1.dart';
import 'package:insta_clone/Pages/authentication/login/login_page.dart';
import 'package:insta_clone/Pages/authentication/signup/password.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  UserModelPrimary user = UserModelPrimary(userName: '', name: '', profilePic: '', number: '', emailAddress: '', followers: [], following: [], allPosts: [ ], allReels: []);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  GestureDetector(
                    onTap: (){
                      _showMyDialogBack(context);
                    },
                      child: const Icon(Icons.arrow_back_outlined)),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text("What's your name?",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Full name",
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                    ),
                    onChanged: (value){
                      user.name=value;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                      width: 500.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                            ),
                        ),
                          onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Password(user: user)));
                          },
                          child: const Text("Next"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 420.0,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        _showMyDialogAlready(context);
                      },
                      child: const Text("Already have an account?",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                      ),
                    ),
                  )
                ]
            ),
          ),
        ),
      ),
    );
  }
  void _showMyDialogBack(BuildContext context){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: const Text("Do you want to stop creating your account?",
        style: TextStyle(
          fontWeight: FontWeight.bold,
            fontSize: 18.0,
        ),
        ),
        content: const Text("If you stop now, you'll lose any progress you've made."),
        actions: [
          TextButton(
          onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
          },
              child: const Text("STOP CREATING ACCOUNT",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
          ),
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            child: const Text("CONTINUE CREATING ACCOUNT",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
                fontSize: 15.0,
            ),
            ),
          )
        ],
      );
    }
    );
  }

  void _showMyDialogAlready(BuildContext context){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: const Text("Already have an account?",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            child: const Text("CONTINUE CREATING ACCOUNT",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
              ),
            ),
          ),
          TextButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: const Text("LOGIN",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
              ),
            ),
          )
        ],
      );
    }
    );
  }
}
