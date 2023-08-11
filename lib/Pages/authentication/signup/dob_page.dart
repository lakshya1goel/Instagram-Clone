import 'package:flutter/material.dart';
import 'package:insta_clone/Models/user_model1.dart';
import 'package:insta_clone/Pages/authentication/login/login_page.dart';
import 'package:insta_clone/Pages/authentication/signup/save_login_info.dart';
import 'package:insta_clone/Pages/authentication/signup/username.dart';
class DobPage extends StatefulWidget {
  final UserModelPrimary user;
  final String password;
  const DobPage({super.key, required this.user,required this.password});

  @override
  State<DobPage> createState() => _DobPageState();
}

class _DobPageState extends State<DobPage> {
  String dob="";
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
                            MaterialPageRoute(builder: (context) => SaveInfo(user: widget.user,password: widget.password,)));
                      },
                      child: Icon(Icons.arrow_back_outlined)),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text("What's your date of birth?",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                              Text(
                              "Use your own date of birth, even if this account is for a business, a pet or something else. No one will see it unless you choose to share it."),
                              TextButton(
                                onPressed: (){

                                },
                                  child: Text("Why I need to provide my date of birth?",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),),
                              )
                            ],
                      )
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Birthday",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                    ),
                    onChanged: (value){
                        dob=value;
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UserName(user:  widget.user,password: widget.password)));
                        },
                        child: Text("Next"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 320.0,
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
