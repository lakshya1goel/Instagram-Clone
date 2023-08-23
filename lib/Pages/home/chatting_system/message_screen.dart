import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Models/ChatRoomModel.dart';
import 'package:insta_clone/Models/MessageModel.dart';
import 'package:insta_clone/Models/UserModel.dart';
import 'package:insta_clone/main.dart';

class MessagesScreen extends StatefulWidget {
  final UserModel targetUser;
  final ChatRoomModel chatroom;
  final UserModel userModel;
  final User firebaseUser;

  MessagesScreen({Key? key, required this.targetUser, required this.chatroom, required this.userModel, required this.firebaseUser}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {

  TextEditingController messageController = TextEditingController();

  void sendMessage() async {
    String msg = messageController.text.trim();
    messageController.clear();

    if(msg != "") {
      // Send Message
      MessageModel newMessage = MessageModel(
          msgId: uuid.v1(),
          sender: widget.userModel.uid,
          createdOn: Timestamp.now(),
          text: msg,
          seen: false
      );

      FirebaseFirestore.instance.collection("chatrooms").doc(widget.chatroom.chatRoomId).collection("messages").doc(newMessage.msgId).set(newMessage.toMap());

      widget.chatroom.lastMsg = msg;
      FirebaseFirestore.instance.collection("chatrooms").doc(widget.chatroom.chatRoomId).set(widget.chatroom.toMap());

      print("Message Sent!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            CircleAvatar(
              radius: 15.0,
              backgroundImage: NetworkImage(widget.targetUser.profilePic.toString()),
            ),
            const SizedBox(width: 15.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.targetUser.name.toString(),
                  style: TextStyle(color: Colors.white,
                      fontSize: 16
                  ),
                ),
                Text(
                  widget.targetUser.username.toString(),
                  style: TextStyle(color: Colors.grey,
                      fontSize: 12
                  ),
                )
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.video_camera_back_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body:SafeArea(
        child: Container(
          child: Column(
            children: [
              // This is where the chats will go
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10
                  ),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("chatrooms").doc(widget.chatroom.chatRoomId).collection("messages").orderBy("createdOn", descending: true).snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.active) {
                        if(snapshot.hasData) {
                          QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;


                          return ListView.builder(
                            reverse: true,
                            itemCount: dataSnapshot.docs.length,
                            itemBuilder: (context, index) {
                              MessageModel currentMessage = MessageModel.fromMap(dataSnapshot.docs[index].data() as Map<String, dynamic>);

                              return Row(
                                mainAxisAlignment: (currentMessage.sender == widget.userModel.uid) ? MainAxisAlignment.end : MainAxisAlignment.start,
                                children: [
                                  Visibility(
                                    visible: currentMessage.sender != widget.userModel.uid,
                                    child: CircleAvatar(
                                      radius:15.0,
                                      backgroundImage:NetworkImage(widget.targetUser.profilePic.toString()),
                                    ),
                                  ),
                                  SizedBox(width: 10.0,),
                                  Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: 2,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: (currentMessage.sender == widget.userModel.uid) ? Colors.indigo[800] : Colors.grey[800],
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: (currentMessage.sender != widget.userModel.uid)?Radius.zero: Radius.circular(20.0),
                                          bottomRight: (currentMessage.sender == widget.userModel.uid)?Radius.zero: Radius.circular(20.0),
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                        ),
                                      ),
                                      constraints: BoxConstraints(
                                        maxWidth: 200, // Set a maximum width for the container
                                      ),
                                      child: Text(
                                        currentMessage.text.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ),
                                      )
                                  ),
                                  SizedBox(width: 10.0,),
                                  Visibility(
                                    visible: currentMessage.sender == widget.userModel.uid,
                                    child: CircleAvatar(
                                      radius:15.0,
                                      backgroundImage:NetworkImage(widget.userModel.profilePic.toString()),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        else if(snapshot.hasError) {
                          return Center(
                            child: Text("An error occured! Please check your internet connection."),
                          );
                        }
                        else {
                          return Center(
                            child: Text("Say hi to your new friend"),
                          );
                        }
                      }
                      else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey[800],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.camera_alt,
                              color: Colors.white,)
                        ),
                      ),
                      SizedBox(width: 10.0,),
                      Flexible(
                        child: TextField(
                          controller: messageController,
                          maxLines: null,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Message...",
                              hintStyle: TextStyle(
                                  color: Colors.grey
                              ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                        },
                        icon: Icon(Icons.mic_none, color: Colors.white,),
                      ),
                      IconButton(
                        onPressed: () {
                        },
                        icon: Icon(Icons.photo_outlined, color: Colors.white,),
                      ),
                      IconButton(
                        onPressed: () {
                          sendMessage();
                        },
                        icon: Icon(Icons.send, color: Colors.white,),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
