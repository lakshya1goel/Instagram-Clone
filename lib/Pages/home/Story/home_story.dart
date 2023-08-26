class StoryPageModel{
  String? image;
  String? userName;
  String? uid;
  bool? seen;
  String? profilePic;
  StoryPageModel({required this.image,required this.userName,required this.seen, required this.profilePic,required this.uid});

  StoryPageModel.fromMap(Map<String,dynamic> story){
    image =story['image'];
    profilePic = story['profilePic'];
    seen = story['seen'];
    userName = story['userName'];
    uid = story['uid'];
  }

  Map<String,dynamic> toMap(){
    return{
      'image':image,
      'profilePic':profilePic,
      'seen':seen,
      'userName':userName,
      'uid':uid,
    };
  }
}