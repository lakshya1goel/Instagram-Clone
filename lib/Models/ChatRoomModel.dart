import 'package:cloud_firestore/cloud_firestore.dart';
class ChatRoomModel{
  String? chatRoomId;
  Map<String, dynamic>? participants;
  String? lastMsg;
  Timestamp? time;
  List<dynamic>? users;
  ChatRoomModel({required this.chatRoomId, required this.participants, required this.lastMsg, required this.time, required this.users});

  ChatRoomModel.fromMap(Map<String, dynamic> map){
    chatRoomId=map["chatRoomId"];
    participants=map["participants"];
    lastMsg=map["lastMsg"];
    time=map["time"];
    users=map["users"];
  }

  Map<String, dynamic> toMap(){
    return{
      "chatRoomId":chatRoomId,
      "participants":participants,
      "lastMsg":lastMsg,
      "time":time,
      "users":users,
    };
  }
}