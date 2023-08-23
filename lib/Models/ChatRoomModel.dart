class ChatRoomModel{
  String? chatRoomId;
  Map<String, dynamic>? participants;
  String? lastMsg;
  ChatRoomModel({required this.chatRoomId, required this.participants, required this.lastMsg});

  ChatRoomModel.fromMap(Map<String, dynamic> map){
    chatRoomId=map["chatRoomId"];
    participants=map["participants"];
    lastMsg=map["lastMsg"];
  }

  Map<String, dynamic> toMap(){
    return{
      "chatRoomId":chatRoomId,
      "participants":participants,
      "lastMsg":lastMsg,
    };
  }
}