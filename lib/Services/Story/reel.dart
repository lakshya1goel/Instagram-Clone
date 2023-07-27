import 'Comment.dart';
class ReelObject{
    String ReelURL;
    String UserName;
    String UserProfilePic;
    String ReelDescription;
    String Music;
    bool Followed;
    bool Liked;
    int Likes;
    int Shares;
    int Comments;
    List<Comment> AllComments;
    ReelObject({required this.ReelURL,required this.UserName,required this.UserProfilePic,
    required this.ReelDescription,required this.Music,required this.Followed,required this.Liked,
    required this.Likes,required this.Shares,required this.Comments,required this.AllComments});
}