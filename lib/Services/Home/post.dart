import 'package:insta_clone/Models/UserModel.dart';

class Post{
  String? postId;
  String? userName;
  int? likes;
  String? description;
  List<String>? images;
  String? profilePic;
  bool? liked;
  Post({required this.postId,required this.userName,required this.liked,required this.likes,required this.description,required this.images,required this.profilePic});

  Map<String,dynamic> toMap(){
    return{
      'postId':postId,
      'userName':userName,
      'likes':likes,
      'description':description,
      'image':images,
      'profilePic':profilePic,
      'liked':liked
    };
  }

  Post.fromMap(Map<String,dynamic> map){
    postId = map['postId'];
    userName = map['userName'];
    likes = map['likes'];
    description = map['description'];
    images = map['image'];
    profilePic = map['profilePic'];
    liked = map['liked'];
  }
}