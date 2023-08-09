import 'package:insta_clone/Services/Story/reel.dart';
import '../Services/Home/post.dart';
class UserModelSecondary{
  String userName;
  String name;
  String profilePic;
  bool isFollower;
  bool isFollowing;
  List<Post> allPosts;
  List<ReelObject> allReels;
  List<UserModelSecondary> followers;
  List<UserModelSecondary> following;
  UserModelSecondary({required this.userName,required this.name,required this.profilePic,required this.isFollower,required this.isFollowing,required this.followers,required this.following,required this.allPosts,required this.allReels});
}