class MessageModel{
  String? sender;
  String? text;
  bool? seen;
  DateTime? createdOn;
  MessageModel({required this.sender, required this.text, required this.seen, required this.createdOn});

  MessageModel.fromMap(Map<String, dynamic> map){
    sender=map["sender"];
    text=map["text"];
    seen=map["seen"];
    createdOn=map["createdOn"];
  }

  Map<String, dynamic> fromMap(){
    return{
      "sender":sender,
      "text":text,
      "seen":seen,
      "createdOn":createdOn,
    };
  }
}