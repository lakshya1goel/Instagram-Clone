import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insta_clone/Pages/authentication/login/login_page.dart';
import 'package:insta_clone/Pages/authentication/signup/username.dart';
class MobileNumber extends StatefulWidget {
  const MobileNumber({super.key});

  @override
  State<MobileNumber> createState() => _MoblieNumberState();
}

class _MoblieNumberState extends State<MobileNumber> {
  String phone_num="";
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
                            MaterialPageRoute(builder: (context) => UserName()));
                      },
                      child: Icon(Icons.arrow_back_outlined)),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text("What's your mobile number?",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text("Enter the mobile number on which you can be contacted. No one will see this on your profile.")
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Mobile number",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                      onChanged: (value){
                          phone_num=value;
                      },
                    ),
                  ),
                  Text("You may receive SMS notifications from us for security and login purposes."),
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

                        },
                        child: Text("Next"),
                      ),
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
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )),
                          elevation: MaterialStateProperty.all<double>(0.0),
                        ),
                        onPressed: () {

                        },
                        child: TextButton(
                          onPressed: (){

                          },
                          child: Text("Sign up with email address",
                            style: TextStyle(
                              color: Colors.black,
                            ),),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 280.0,
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
