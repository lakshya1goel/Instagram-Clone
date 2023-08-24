import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Services/Home/post.dart';
import 'package:uuid/uuid.dart';
import '../../../Models/UserModel.dart';
class UploadPost{
  List<File> posts;
  UserModel user;
  String description;
  UploadPost({required this.posts,required this.user,required this.description});


  void uploadPost(BuildContext context) async {
    String path = "/posts/${user.username}";
    FirebaseFirestore database = FirebaseFirestore.instance;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref();
    String postId = Uuid().v1();
    List<String> singlePost = [];

    int totalUploads = posts.length;
    int completedUploads = 0;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Uploading Post"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LinearProgressIndicator(
                value: completedUploads / totalUploads,
              ),
              SizedBox(height: 16),
              Text("Uploaded $completedUploads out of $totalUploads"),
            ],
          ),
        );
      },
    );

    for (int post = 0; post < totalUploads; post++) {
      UploadTask uploadTask = ref.child("$path/${DateTime.now()}").putFile(posts[post]);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        double progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        print("Upload progress: $progress%");
      }, onError: (Object e) {
        print("Upload error: $e");
      });

      await uploadTask.whenComplete(() {
        completedUploads++;
        Navigator.of(context).pop();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Uploading Post"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LinearProgressIndicator(
                    value: completedUploads / totalUploads,
                  ),
                  SizedBox(height: 16),
                  Text("Uploaded $completedUploads out of $totalUploads"),
                ],
              ),
            );
          },
        );
      });

      final downloadURL = await uploadTask.snapshot.ref.getDownloadURL();
      singlePost.add(downloadURL);
    }

    Navigator.of(context).pop();

    Map<String, dynamic> newPost = Post(
      postId: postId,
      userId: user.uid,
      userName: user.username,
      liked: false,
      likes: 0,
      description: description,
      images: singlePost,
      profilePic: user.profilePic,
    ).toMap();

    await database.collection('users').doc(user.uid).collection('posts').doc(postId).set(newPost);
    Navigator.pop(context);
  }


}
