import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../../Models/UserModel.dart';
import 'home_story.dart';
class UploadStory{
  XFile? story;
  UserModel user;
  UploadStory({required this.story,required this.user});


  void uploadStory(BuildContext context) async {
    File storyToUpload = File(story!.path);
    String path = "/story/${user.username}";
    FirebaseFirestore database = FirebaseFirestore.instance;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref();
    String storyId = const Uuid().v1();


    UploadTask uploadTask = ref.child("$path/${DateTime.now()}").putFile(storyToUpload);

    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      double progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
      print("Upload progress: $progress%");
    }, onError: (Object e) {
      print("Upload error: $e");
    });
    String downloadURL = "";

    await uploadTask.whenComplete(() async { downloadURL = await uploadTask.snapshot.ref.getDownloadURL();});




    Map<String, dynamic> newPost = StoryPageModel(
        userName: user.username, profilePic: user.profilePic, image: downloadURL, seen: false,uid: user.uid
    ).toMap();

    await database.collection('users').doc(user.uid).collection('stories').doc(storyId).set(newPost);
  }


}
