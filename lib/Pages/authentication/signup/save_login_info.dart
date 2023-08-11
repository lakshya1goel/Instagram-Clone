import 'package:flutter/material.dart';
import 'package:insta_clone/Models/user_model1.dart';
import 'package:insta_clone/Pages/authentication/login/login_page.dart';
import 'package:insta_clone/Pages/authentication/signup/dob_page.dart';
import 'package:insta_clone/Pages/authentication/signup/password.dart';
class SaveInfo extends StatefulWidget {
  final String password;
  final UserModelPrimary user;
  const SaveInfo({super.key,required this.user,required this.password});

  @override
  State<SaveInfo> createState() => _SaveInfoState();
}

class _SaveInfoState extends State<SaveInfo> {
  bool save=false;
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
                            MaterialPageRoute(builder: (context) => Password(user: widget.user,)));
                      },
                      child: Icon(Icons.arrow_back_outlined)),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text("Save your login info?",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Text(
                          "We'll save the login info for your new account, so you won't need to enter it the next time you log in.")
                  ),
                  SizedBox(
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => DobPage(user:  widget.user,password:widget.password)),
                        );
                        save=true;
                      },
                      child: Text("Save"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      width: 500.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.white),
                          side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(width: 2.0, color: Colors.grey),
                          ),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          elevation: MaterialStateProperty.all<double>(0.0),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => DobPage(user: widget.user,password: widget.password,))
                          );
                          save=false;
                        },
                        child: Text("Not Now",
                        style: TextStyle(
                          color: Colors.black,
                        ),),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 400.0,
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
  void _showMyDialogAlready(BuildContext context) {
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Already have an account?",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
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
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
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
