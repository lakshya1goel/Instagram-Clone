class UserModel{
  String? uid;
  String? name;
  String? username;
  String? email;
  String? profilePic;
  String? pronouns;
  String? bio;
  UserModel({required this.uid, required this.profilePic, required this.name, required this.email, required this.username, required this.pronouns, required this.bio});

  UserModel.fromMap(Map<String, dynamic> map){
    uid=map["uid"];
    name=map["name"];
    username=map["username"];
    email=map["email"];
    profilePic=map["profilePic"];
    pronouns=map["pronouns"];
    bio=map["bio"];
  }

  Map<String, dynamic> toMap(){
    return{
      "uid":uid,
      "name":name,
      "username":username,
      "email":email,
      "profilePic":profilePic,
      "pronouns":pronouns,
      "bio":bio,
    };
  }
}