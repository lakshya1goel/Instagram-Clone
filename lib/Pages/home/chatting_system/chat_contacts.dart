import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Models/ChatRoomModel.dart';
import 'package:insta_clone/Models/FirebaseHelper.dart';
import 'package:insta_clone/Models/UserModel.dart';
import 'package:insta_clone/Pages/home/chatting_system/message_screen.dart';
import '../../../Services/profile_accounts.dart';
import '../../../main.dart';

class ChatContact extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  ChatContact({Key? key, required this.userModel, required this.firebaseUser}) : super(key: key);

  @override
  State<ChatContact> createState() => _ChatContactState();
}

class _ChatContactState extends State<ChatContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
        backgroundColor: Colors.black,
        pinned: true,
        title: Row(
          children: [
            Text(
              widget.userModel.username.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0
              ),
            ),
            IconButton(
                onPressed: (){
                  _bottomSheet(context);
                },
                icon: Icon(Icons.keyboard_arrow_down)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
            },
            icon: const Icon(Icons.video_call,
              size: 30.0,
            ),
          ),
          IconButton(
            onPressed: () {
            },
            icon: const Icon(Icons.pages),
          ),
        ],
      ),
          // const SliverToBoxAdapter(),
          SliverPersistentHeader(
            pinned: true,
            delegate: Space(
              child: Container(
                color: Colors.black,
              ),
            ),
          ),
        ],
        body:Column(
            children: [
              buildSearchBar(userModel: widget.userModel, firebaseUser: widget.firebaseUser,),
              //Notes(),
              Container(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("chatrooms").where("participants.${widget.userModel.uid}", isEqualTo: true).orderBy("time").snapshots(),
                  builder: (context, snapshot){
                    if(snapshot.connectionState==ConnectionState.active){
                      if(snapshot.hasData){
                        QuerySnapshot chatRoomSnapshot = snapshot.data as QuerySnapshot;

                        return Expanded(
                          child: ListView.builder(
                            itemCount: chatRoomSnapshot.docs.length,
                            itemBuilder: (context,index){
                              ChatRoomModel chatRoomModel=ChatRoomModel.fromMap(chatRoomSnapshot.docs[index].data() as Map<String, dynamic>);

                              Map<String, dynamic> participants=chatRoomModel.participants!;
                              List<String> participantsKeys=participants.keys.toList();
                              participantsKeys.remove(widget.userModel.uid);

                              return FutureBuilder(
                                future: FirebaseHelper.getUserModelById(participantsKeys[0]),
                                builder: (context, userData){

                                  if(userData.connectionState==ConnectionState.done){
                                    if(userData.data!=null){
                                      UserModel targetUser=userData.data as UserModel;
                                      return ListTile(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                            return MessagesScreen(targetUser: targetUser, chatroom: chatRoomModel, userModel: widget.userModel, firebaseUser: widget.firebaseUser);
                                          }),
                                          );
                                        },
                                        leading: CircleAvatar(
                                          radius: 25.0,
                                          backgroundImage: NetworkImage(targetUser.profilePic.toString()),
                                        ),
                                        title: Text(targetUser.name.toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        subtitle: (chatRoomModel.lastMsg.toString()!="") ? Text(chatRoomModel.lastMsg.toString()  ,
                                          style: TextStyle(color: Colors.grey),
                                          overflow: TextOverflow.ellipsis ,
                                          maxLines: 1,
                                        ):
                                        Text("Tap to Message"),
                                        trailing: Icon(Icons.camera_alt_outlined,
                                          color: Colors.white,
                                          size: 30.0,
                                        ),
                                      );
                                    }
                                    else{
                                      return Container();
                                    }
                                  }
                                  else{
                                    return Container();
                                  }
                                },
                              );
                            },
                          ),
                        );
                      }
                      else if(snapshot.hasError){
                        return Center(
                          child: Text(
                            snapshot.error.toString(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }
                      else{
                        return Center(
                          child: Text("No Chats",
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                        );
                      }
                    }
                    else{
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ]
        ),
      ),
    );
  }
}

void _bottomSheet(context){
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
    ),
    context: context,
    builder: (BuildContext icon) {
      return Profile_accounts();
    },
  );
}
class Profile_accounts extends StatefulWidget {
  const Profile_accounts({super.key});

  @override
  State<Profile_accounts> createState() => _Profile_accountsState();
}

class _Profile_accountsState extends State<Profile_accounts> {
  List<profile_accounts>accounts=[
    profile_accounts(image: 'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/825fb915-d6a8-4bd2-ba12-ba661266a6f9/dfndnu7-e10d71e6-3427-4bda-a7f1-8dc8a55fb968.png/v1/fill/w_894,h_894,q_70,strp/bigred_cute_anime_boy_with_black_hair_and_big_blue_by_sketchesbydani_dfndnu7-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTAyNCIsInBhdGgiOiJcL2ZcLzgyNWZiOTE1LWQ2YTgtNGJkMi1iYTEyLWJhNjYxMjY2YTZmOVwvZGZuZG51Ny1lMTBkNzFlNi0zNDI3LTRiZGEtYTdmMS04ZGM4YTU1ZmI5NjgucG5nIiwid2lkdGgiOiI8PTEwMjQifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.8v_PPYlfNxvYxB4wNAtsR4TPaGugUJcqnx6SSJLEWTU', name: '43.paras.57'),
  ];
  String account="";
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xDD000000),
      height: 170.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
            child: Center(
              child: Container(height: 4.0,width: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                return ListTile(
                    leading: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(accounts[index].image),
                        ),
                      ),
                    ),
                    title: Text(accounts[index].name,
                      style: TextStyle(
                          color: Colors.white
                      ),),
                    trailing:
                    Radio(
                      value: index,
                      groupValue: selectedIndex,
                      onChanged: (value) {
                        account = accounts[index].name;
                      },
                    )
                );
              },
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                      onPressed: (){

                      },
                      icon: Icon(Icons.add,
                        color: Colors.white,
                        size: 40.0,
                      )
                  ),
                ),
              ),
              Text('Add account',
                style: TextStyle(
                    color: Colors.white
                ),),
            ],
          ),
        ],
      ),
    );
  }
}


class buildSearchBar extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  buildSearchBar({Key? key, required this.userModel, required this.firebaseUser}) : super(key: key);

  @override
  State<buildSearchBar> createState() => _buildSearchBarState();
}

class _buildSearchBarState extends State<buildSearchBar> {
  String searched="";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Card(
        color: Colors.grey[850],
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
          child: Container(
            height: 35.0,
            child: TextFormField(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchMode(userModel:widget.userModel, firebaseUser: widget.firebaseUser,)),
                );
              },
              style: TextStyle(color: Colors.white), // Text color
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search,
                    size: 20.0,
                    color: Colors.grey),
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                searched=value;
              },
            ),
          ),
        ),
      ),
    );
  }
}


class Space extends SliverPersistentHeaderDelegate {
  final Widget child;

  Space({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 0;

  @override
  // TODO: implement minExtent
  double get minExtent => 0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class SearchMode extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  SearchMode({Key? key, required this.userModel, required this.firebaseUser}) : super(key: key);

  @override
  State<SearchMode> createState() => _SearchModeState();
}

class _SearchModeState extends State<SearchMode> {
  TextEditingController searchController=TextEditingController();
  final _searchFocusNode = FocusNode();

  Future<ChatRoomModel?> getChatroomModel(UserModel targetUser) async {
    ChatRoomModel? chatRoom;
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("chatrooms").where("participants.${widget.userModel.uid}", isEqualTo: true).where("participants.${targetUser.uid}", isEqualTo: true).get();

    if(snapshot.docs.length > 0) {
      // Fetch the existing one
      print("ChatRoom already exist!");
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatroom = ChatRoomModel.fromMap(docData as Map<String, dynamic>);
      chatRoom = existingChatroom;
    }
    else {
      // Create a new one
      ChatRoomModel newChatroom = ChatRoomModel(
        chatRoomId: uuid.v1(),
        lastMsg: "",
        participants: {
          widget.userModel.uid.toString(): true,
          targetUser.uid.toString(): true,
        },
        time: Timestamp.now(),
      );
      await FirebaseFirestore.instance.collection("chatrooms").doc(newChatroom.chatRoomId).set(newChatroom.toMap());
      chatRoom = newChatroom;
      log("New Chatroom Created!");
    }

    return chatRoom;
  }

  @override
  void initState() {
    super.initState();
    // Open the keyboard automatically when the page is navigated to
    _requestSearchFieldFocus();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _requestSearchFieldFocus() {
    // Delaying the focus request to ensure the keyboard is shown properly
    Future.delayed(Duration(milliseconds: 100), () {
      FocusScope.of(context).requestFocus(_searchFocusNode);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 25.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              color: Colors.grey[850],
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: searchController,
                  focusNode: _searchFocusNode,
                  style: TextStyle(color: Colors.white), // Text color
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  onFieldSubmitted: (value){
                    setState(() {

                    });
                  },
                ),
              ),
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users").where("username", isEqualTo: searchController.text).snapshots(),
            builder: (context, snapshot){
              if(snapshot.connectionState==ConnectionState.active){
                if(snapshot.hasData){
                  QuerySnapshot dataSnapshot=snapshot.data as QuerySnapshot;
                  if(dataSnapshot.docs.length>0){
                    Map<String, dynamic> userMap=dataSnapshot.docs[0].data() as Map<String, dynamic>;
                    UserModel searchedUser=UserModel.fromMap(userMap);

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        onTap: () async{
                          ChatRoomModel? chatroomModel=await getChatroomModel(searchedUser);
                          if(chatroomModel!=null){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                              return MessagesScreen(
                                targetUser: searchedUser,
                                userModel: widget.userModel,
                                firebaseUser: widget.firebaseUser,
                                chatroom: chatroomModel,
                              );
                            }));
                          }
                        },
                        leading: CircleAvatar(
                          radius: 25.0,
                          backgroundImage: NetworkImage(searchedUser.profilePic!),
                        ),
                        title: Text(searchedUser.name!,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(searchedUser.username!,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    );
                  }
                  else{
                    return Text("No Result Found!",
                      style: TextStyle(color: Colors.white),
                    );
                  }
                }
                else if(snapshot.hasError){
                  return Text("An Error Occured!",
                    style: TextStyle(color: Colors.white),
                  );
                }
                else{
                  return Text("No Result Found!",
                    style: TextStyle(color: Colors.white),
                  );
                }
              }
              else{
                return CircularProgressIndicator();
              }
            } ,

          ),
        ],
      ),
    );
  }
}

