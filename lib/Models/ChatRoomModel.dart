class ChatRoomModel{
  String? chatRoomId;
  List<String>? participants;
  ChatRoomModel({required this.chatRoomId, required this.participants});

  ChatRoomModel.fromMap(Map<String, dynamic> map){
    chatRoomId=map["chatRoomId"];
    participants=map["participants"];
  }

  Map<String, dynamic> toMap(){
    return{
      "chatRoomId":chatRoomId,
      "participants":participants,
    };
  }
}