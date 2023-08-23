import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:insta_clone/Services/Home/post.dart';
import '../../../Models/UserModel.dart';
import '../../../main.dart';
class UploadPost{
  List<File> posts;
  UserModel user;
  String description;
  UploadPost({required this.posts,required this.user,required this.description});

  void uploadPost() async {
    String path = "/posts";
    FirebaseFirestore database = FirebaseFirestore.instance;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref();
    String postId = uuid.v1();
    List<String> singlePost = [];
    for(int post=0;post<posts.length;post++){
      final snapshot = await ref.child("$path/${DateTime.now()}").putFile(posts[post]).whenComplete(() => {});
      final downloadURL = await snapshot.ref.getDownloadURL();
      singlePost.add(downloadURL);
    }
    Map<String,dynamic> newPost = Post(postId: postId, userName: user.username, liked: false, likes: 0, description: description, images: singlePost, profilePic: user.profilePic).toMap();
    await database.collection('users').doc(user.uid).collection('posts').doc(postId).set(newPost);
    print("its successfully done man!!");
  }
}
