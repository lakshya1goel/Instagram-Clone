import 'package:cloud_firestore/cloud_firestore.dart';
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
    });
  }
  UserModelPrimary getUserFromSnapShot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return UserModelPrimary(
      userName: data['userName'],
      name: data['name'],
      profilePic: data['profilePic'],
      number: data['number'],
      emailAddress: data['emailAddress'],
      followers: [],
      following: [],
      allPosts: [],
      allReels: [],
    );
  }
    Future<UserModelPrimary> getUserData() async {
      return databaseReference.doc(uid).get().then((value) {
        return getUserFromSnapShot(value);
      });
    }
}