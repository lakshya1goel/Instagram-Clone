import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:insta_clone/Models/user_model1.dart';

class Database {

  final String uid;

  Database({ required this.uid});

  final CollectionReference databaseReference = FirebaseFirestore.instance
      .collection('user');

  Future updateUserData(UserModelPrimary user) async {
    return await databaseReference.doc(uid).set({
      'userName' : user.userName,
      'name':user.name,
      'profilePic':user.profilePic,
      'number':user.number,
      'emailAddress':user.emailAddress,
      'followers':user.followers,
      'following': user.following,
      'allPosts':user.allPosts,
      'allReels':user.allReels,
    });
  }
}