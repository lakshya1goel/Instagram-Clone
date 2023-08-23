import 'package:cloud_firestore/cloud_firestore.dart';
class ChatRoomModel{
  String? chatRoomId;
  Map<String, dynamic>? participants;
  String? lastMsg;
  Timestamp? time;
  ChatRoomModel({required this.chatRoomId, required this.participants, required this.lastMsg, required this.time});

  ChatRoomModel.fromMap(Map<String, dynamic> map){
    chatRoomId=map["chatRoomId"];
    participants=map["participants"];
    lastMsg=map["lastMsg"];
    time=map["time"];
  }

  Map<String, dynamic> toMap(){
    return{
      "chatRoomId":chatRoomId,
      "participants":participants,
      "lastMsg":lastMsg,
      "time":time,
    };
  }
}