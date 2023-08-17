class UserModel{
  String? uid;
  String? name;
  String? username;
  String? email;
  String? profilePic;
  UserModel({required this.uid, required this.profilePic, required this.name, required this.email, required this.username});

  UserModel.fromMap(Map<String, dynamic> map){
    uid=map["uid"];
    name=map["name"];
    username=map["username"];
    email=map["email"];
    profilePic=map["profilePic"];
  }

  Map<String, dynamic> toMap(){
    return{
      "uid":uid,
      "name":name,
      "username":username,
      "email":email,
      "profilePic":profilePic,
    };
  }
}