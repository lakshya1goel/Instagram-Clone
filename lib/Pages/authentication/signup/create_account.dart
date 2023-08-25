// import 'package:flutter/material.dart';
// import 'package:insta_clone/Pages/authentication/login/login_page.dart';
// import 'package:insta_clone/Pages/authentication/signup/password.dart';
// class SignUp extends StatefulWidget {
//   const SignUp({super.key});
//
//   @override
//   State<SignUp> createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//   String name="";
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
//                 children:[
//                   GestureDetector(
//                     onTap: (){
//                       _showMyDialogBack(context);
//                     },
//                       child: Icon(Icons.arrow_back_outlined)),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 20.0),
//                     child: Text("What's your name?",
//                     style: TextStyle(
//                       fontSize: 25.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     ),
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       hintText: "Full name",
//                       hintStyle: TextStyle(color: Colors.grey),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0)
//                       ),
//                     ),
//                     onChanged: (value){
//                       name=value;
//                     },
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 20.0),
//                     child: SizedBox(
//                       width: 500.0,
//                       child: ElevatedButton(
//                         style: ButtonStyle(
//                             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20.0),
//                                 ),
//                             ),
//                         ),
//                           onPressed: (){
//                             Navigator.push(context,
//                                 MaterialPageRoute(builder: (context) => PassWord()));
//                           },
//                           child: Text("Next"),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 420.0,
//                   ),
//                   Center(
//                     child: GestureDetector(
//                       onTap: (){
//                         _showMyDialogAlready(context);
//                       },
//                       child: Text("Already have an account?",
//                       style: TextStyle(
//                         color: Colors.blue,
//                       ),
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
//   void _showMyDialogBack(BuildContext context){
//     showDialog(context: context, builder: (BuildContext context){
//       return AlertDialog(
//         title: Text("Do you want to stop creating your account?",
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//             fontSize: 18.0,
//         ),
//         ),
//         content: Text("If you stop now, you'll lose any progress you've made."),
//         actions: [
//           TextButton(
//           onPressed: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
//           },
//               child: Text("STOP CREATING ACCOUNT",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 15.0,
//                 ),
//               ),
//           ),
//           TextButton(
//             onPressed: (){
//               Navigator.of(context).pop();
//             },
//             child: Text("CONTINUE CREATING ACCOUNT",
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//                 fontSize: 15.0,
//             ),
//             ),
//           )
//         ],
//       );
//     }
//     );
//   }
//
//   void _showMyDialogAlready(BuildContext context){
//     showDialog(context: context, builder: (BuildContext context){
//       return AlertDialog(
//         title: Text("Already have an account?",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 18.0,
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: (){
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
//             onPressed: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
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
