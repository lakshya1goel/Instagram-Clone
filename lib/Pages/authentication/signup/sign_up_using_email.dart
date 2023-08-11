import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insta_clone/Models/user_model1.dart';
import 'package:insta_clone/Pages/authentication/login/login_page.dart';
import 'package:insta_clone/Pages/authentication/signup/username.dart';
import 'package:insta_clone/Services/database.dart';
class EmailAddress extends StatefulWidget {
  final UserModelPrimary user;
  final String password;
  const EmailAddress({super.key, required this.user, required this.password});

  @override
  State<EmailAddress> createState() => _EmailAddressState();
}

class _EmailAddressState extends State<EmailAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserName(
                                  user: widget.user,
                                  password: widget.password,
                                )));
                  },
                  child: const Icon(Icons.arrow_back_outlined)),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "What's your Email adddress?",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                      "Enter the Email on which you can be contacted. No one will see this on your profile.")),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Email Address",
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  onChanged: (value) {
                    widget.user.emailAddress = value;
                  },
                ),
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
                    onPressed: () {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: widget.user.emailAddress,
                              password: widget.password)
                          .then((value) async {
                        await Database(uid: value.user!.uid).updateUserData(widget.user);
                        print(widget.user);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      }).onError((error, stackTrace) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Some Error Occured"),
                                content:  Text(
                                    error.toString()),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }, child: const Text("Retry")),
                                  TextButton(onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
                                  }, child: const Text('Login'))
                                ],
                              );
                            });
                      });
                    },
                    child: const Text("Next"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: 500.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(width: 2.0, color: Colors.grey),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                      elevation: MaterialStateProperty.all<double>(0.0),
                    ),
                    onPressed: () {},
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Sign up with Mobile Number instead",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 280.0,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _showMyDialogAlready(context);
                  },
                  child: const Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  void _showMyDialogAlready(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Already have an account?",
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
                child: const Text(
                  "CONTINUE CREATING ACCOUNT",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const LoginPage()));
                },
                child: const Text(
                  "LOGIN",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
              )
            ],
          );
        });
  }
}
