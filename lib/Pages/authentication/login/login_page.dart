import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:insta_clone/Utils/routes.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username="";
  String password="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 95),
              _centerWidget(),
              SizedBox(height: 60),
              _bottomWidget()
            ],
          ) ,
        ),
      ),
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

  Widget _bottomWidget(){
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "Username, email address or mobile number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
              ),
              onChanged: (value){
                username=value;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                ),
                onChanged: (value){
                  password=value;
                },
              ),
            ),
            SizedBox(
              width: 500.0,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ))
                ),
                  onPressed: (){

                  },
                  child: Text("Log In"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:15.0),
              child: GestureDetector(
                onTap: (){

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
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(width: 2.0,color: Colors.blue),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    )),
                  elevation: MaterialStateProperty.all<double>(0.0),
                ),
                  onPressed: (){

                  },
                  child: Text("Create new account",
                  style: TextStyle(
                    color: Colors.blue,
                  ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
