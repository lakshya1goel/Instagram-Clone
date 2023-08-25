// import 'package:flutter/material.dart';
// import 'package:insta_clone/Pages/authentication/signup/create_account.dart';
// import 'package:insta_clone/Pages/authentication/login/login_page.dart';
// import 'package:insta_clone/Pages/authentication/signup/save_login_info.dart';
// class PassWord extends StatefulWidget {
//   const PassWord({super.key});
//
//   @override
//   State<PassWord> createState() => _PassWordState();
// }
//
// class _PassWordState extends State<PassWord> {
//   bool _obscureText = true;
//   String password="";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(20.0),
//           child: SingleChildScrollView(
//             child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   GestureDetector(
//                       onTap: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) => SignUp()));
//                       },
//                       child: Icon(Icons.arrow_back_outlined)),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 20.0),
//                     child: Text("Create a password",
//                       style: TextStyle(
//                         fontSize: 25.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                       padding: EdgeInsets.only(bottom: 20.0),
//                       child: Text(
//                           "Create a password with at least 6 letters or numbers. It should be something that others can't guess.")
//                   ),
//                   TextFormField(
//                     obscureText: _obscureText,
//                     decoration: InputDecoration(
//                       hintText: "Password",
//                       hintStyle: TextStyle(color: Colors.grey),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0)
//                       ),
//                       suffixIcon: GestureDetector(
//                         onTap: (){
//                           setState(() {
//                             _obscureText= !_obscureText;
//                           });
//                         },
//                         child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility,),
//                       ),
//                     ),
//                     onChanged: (value){
//                       password=value;
//                     },
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 20.0),
//                     child: SizedBox(
//                       width: 500.0,
//                       child: ElevatedButton(
//                         style: ButtonStyle(
//                           shape: MaterialStateProperty.all<
//                               RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20.0),
//                             ),
//                           ),
//                         ),
//                         onPressed: () {
//                           Navigator.push(context,
//                               MaterialPageRoute(builder: (context) => SaveInfo())
//                           );
//                         },
//                         child: Text("Next"),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 350.0,
//                   ),
//                   Center(
//                     child: GestureDetector(
//                       onTap: () {
//                         _showMyDialogAlready(context);
//                       },
//                       child: Text("Already have an account?",
//                         style: TextStyle(
//                           color: Colors.blue,
//                         ),
//                       ),
//                     ),
//                   )
//                 ]
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showMyDialogAlready(BuildContext context) {
//     showDialog(context: context, builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text("Already have an account?",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 18.0,
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text("CONTINUE CREATING ACCOUNT",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 15.0,
//               ),
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => LoginPage()));
//             },
//             child: Text("LOGIN",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 15.0,
//               ),
//             ),
//           )
//         ],
//       );
//     }
//     );
//   }
// }
//
