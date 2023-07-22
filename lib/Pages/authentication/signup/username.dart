import 'package:flutter/material.dart';
import 'package:insta_clone/Pages/authentication/login/login_page.dart';
import 'package:insta_clone/Pages/authentication/signup/dob_page.dart';
import 'package:insta_clone/Pages/authentication/signup/mobile_number.dart';
class UserName extends StatefulWidget {
  const UserName({super.key});

  @override
  State<UserName> createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {
  String username="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => DobPage()));
                      },
                      child: Icon(Icons.arrow_back_outlined)),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text("Create a username",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text("Add a username or use our suggestions. You can change this at any time.")
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Username",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                    ),
                    onChanged: (value){
                        username=value;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                      width: 500.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MobileNumber()));
                        },
                        child: Text("Next"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 380.0,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _showMyDialogAlready(context);
                      },
                      child: Text("Already have an account?",
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
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
}
