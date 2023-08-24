import 'package:flutter/material.dart';
import 'package:insta_clone/Models/ErrorMessage.dart';
import 'package:insta_clone/Models/UserModel.dart';
import 'package:insta_clone/Pages/authentication/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class signup_page extends StatefulWidget {
  const signup_page({super.key});

  @override
  State<signup_page> createState() => _signup_pageState();
}

class _signup_pageState extends State<signup_page> {
  bool _obscureText1=true;
  bool _obscureText2=true;


  TextEditingController nameController= TextEditingController();
  TextEditingController usernameController= TextEditingController();
  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  TextEditingController confirmPasswordController= TextEditingController();


  void checkValues(){
    String name=nameController.text.trim();
    String username=usernameController.text.trim();
    String email=emailController.text.trim();
    String password=passwordController.text.trim();
    String confirmPassword=confirmPasswordController.text.trim();

    if(name=="" || username=="" || email=="" || password=="" || confirmPassword==""){
      print("Please fill all the fields!");
      ErrorMessage.showAlertDialog(context, "Incomplete Data", "Please fill all the fields");
    }
    else if(password!=confirmPassword){
      print("Passwords do not match!");
      ErrorMessage.showAlertDialog(context, "Password Mismatch", "The passwords you entered do not match!");
    }
    else{
      print("SignUp Successfull!");
      signup(email, password, name, username);
    }
  }


  void signup(String email, String password, String name, String username) async{
    UserCredential? credential;
    try{
      credential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(ex){
      print(ex.code.toString());
      Navigator.pop(context);
      ErrorMessage.showAlertDialog(context, "An error occured", ex.message.toString());
    }

    if(credential!=null){
      String uid=credential.user!.uid;
      UserModel newUser=UserModel(uid: uid, profilePic: "", name: name, email: email, username: username);
      await FirebaseFirestore.instance.collection("users").doc(uid).set(newUser.toMap()).then((value){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LoginPage()));
      });
    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Account"),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                    ),
                    onChanged: (value) {
                    },
                  ),
                ),
                SizedBox(height: 15.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: "UserName",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                    ),
                    onChanged: (value) {
                    },
                  ),
                ),
                SizedBox(height: 15.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                    ),
                    onChanged: (value) {
                    },
                  ),
                ),
                SizedBox(height: 15.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: _obscureText1,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      suffixIcon: GestureDetector(
                        onTap: (){
                          setState(() {
                            _obscureText1= !_obscureText1;
                          }
                          );
                        },
                        child: Icon(_obscureText1 ? Icons.visibility_off : Icons.visibility,),
                      ),
                    ),
                    onChanged: (value) {
                    },
                  ),
                ),
                SizedBox(height: 15.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: confirmPasswordController,
                    obscureText: _obscureText2,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      suffixIcon: GestureDetector(
                        onTap: (){
                          setState(() {
                            _obscureText2= !_obscureText2;
                          }
                          );
                        },
                        child: Icon(_obscureText2 ? Icons.visibility_off : Icons.visibility,),
                      ),
                    ),
                    onChanged: (value) {
                    },
                  ),
                ),
                SizedBox(height: 25.0,),
                SizedBox(
                  width: 320.0,
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
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 100.0,),
                GestureDetector(
                  onTap: (){
                    _showMyDialogAlready(context);
                  },
                  child: Text("Already have an account?",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
void _showMyDialogAlready(BuildContext context){
  showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      title: Text("Already have an account?",
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
          child: Text("CONTINUE CREATING ACCOUNT",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
            ),
          ),
        ),
        TextButton(
          onPressed: (){
            //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
          child: Text("LOGIN",
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
