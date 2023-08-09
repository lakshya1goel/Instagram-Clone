import 'package:insta_clone/Models/user_model2.dart';
import 'package:insta_clone/Services/Story/reel.dart';
import '../Services/Home/post.dart';

class UserModelPrimary{
  String userName;
  String name;
  String profilePic;
  String number;
  String emailAddress;
  List<UserModelSecondary> followers;
  List<UserModelSecondary> following;
  List<Post> allPosts;
  List<ReelObject> allReels;
  UserModelPrimary({required this.userName,required this.name,required this.profilePic,required this.number,required this.emailAddress,required this.followers,required this.following,required this.allPosts,required this.allReels});
}