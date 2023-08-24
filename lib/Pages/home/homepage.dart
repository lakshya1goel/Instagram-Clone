import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Models/UserModel.dart';
import 'package:insta_clone/Pages/home/chatting_system/chat_contacts.dart';
import 'package:insta_like_button/insta_like_button.dart';
import 'package:insta_clone/Services/Home/home_story.dart';
import 'package:insta_clone/Services/Home/post.dart';
import 'package:insta_clone/Utils/expandable_text.dart';
import 'package:pinch_zoom_release_unzoom/pinch_zoom_release_unzoom.dart';
import 'Stories.dart';

class HomePage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  HomePage({Key? key, required this.userModel, required this.firebaseUser}) : super(key: key);
  final List<Post> posts = [];
  List<home_story> stories = [
    home_story(
        Imgae: 'https://bit.ly/3qdxC3s',
        username: '43.paras.57-1',
        seen: false),
    home_story(
        Imgae: 'https://bit.ly/3qdxC3s',
        username: '43.paras.57-1',
        seen: false),
    home_story(
        Imgae: 'https://bit.ly/3qdxC3s',
        username: '43.paras.57-1',
        seen: false),
    home_story(
        Imgae: 'https://bit.ly/3qdxC3s',
        username: '43.paras.57-1',
        seen: false),
    home_story(
        Imgae: 'https://bit.ly/3qdxC3s',
        username: '43.paras.57-1',
        seen: false),
    home_story(
        Imgae: 'https://bit.ly/3qdxC3s',
        username: '43.paras.57-1',
        seen: false),
    home_story(
        Imgae: 'https://bit.ly/3qdxC3s',
        username: '43.paras.57-2',
        seen: false),
    home_story(
        Imgae: 'https://bit.ly/3qdxC3s',
        username: '43.paras.57-3',
        seen: false),
  ];
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamController postStream = StreamController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double StorySize = 0.09 * width;
    print('$height & $width');
    return CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 50,
            floating: true,
            snap: true,
            title: Row(
              children: [
                const SizedBox(width: 10),
                const Image(
                  height: 55,
                  width: 110,
                  image: AssetImage(
                    'assets/images/home_page/instagram.png',
                  ),
                ),
                const Spacer(),
                Container(
                  height: 25,
                  width: 25,
                  child: const Image(
                    image: AssetImage('assets/Icons/love.png'),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 25,
                  width: 25,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatContact(userModel: widget.userModel, firebaseUser: widget.firebaseUser,)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                    ),
                    child: const Image(
                      image: AssetImage('assets/Icons/send.png'),
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.black,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: height * 0.107,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.stories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Padding(
                            padding: index == 0
                                ? EdgeInsets.fromLTRB(20, 0, 0, 0)
                                : EdgeInsets.fromLTRB(15, 0, 0, 0),
                            child: InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StoriesPage(
                                              selected_page: index,
                                              status: widget.stories)));
                                  setState(() {
                                    home_story My_story = widget.stories[0];
                                    List<home_story> remainingItems =
                                        List.from(widget.stories.sublist(1));
                                    remainingItems
                                        .sort((a, b) => a.seen ? 1 : -1);
                                    widget.stories = [
                                      My_story,
                                      ...remainingItems
                                    ];
                                  });
                                },
                                child: CircleAvatar(
                                  radius: StorySize,
                                  child: Container(
                                    decoration: !widget.stories[index].seen
                                        ? const BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color(0xFF9B2282),
                                                  Color(0xFFEEA863)
                                                ]))
                                        : BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey[700]),
                                    child: CircleAvatar(
                                      radius: !widget.stories[index].seen
                                          ? StorySize
                                          : StorySize + 0.2,
                                      backgroundColor: Colors.transparent,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.black,
                                        radius: !widget.stories[index].seen
                                            ? StorySize - 2.5
                                            : StorySize - 1.5,
                                        child: Stack(
                                          children: [
                                            CircleAvatar(
                                              radius: StorySize - 5,
                                              backgroundImage: NetworkImage(
                                                  widget.stories[index].Imgae),
                                            ),
                                            index == 0
                                                ? Positioned(
                                                    left: 55,
                                                    top: 55,
                                                    child: Icon(
                                                      Icons.add_circle,
                                                      color: Colors.blue,
                                                    ),
                                                  )
                                                : SizedBox()
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                          Text(
                            widget.stories[index].username,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<Object>(
            stream: FirebaseFirestore.instance.collection('users').doc(widget.userModel.uid).collection('posts').snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                QuerySnapshot postQuery = snapshot.data as QuerySnapshot;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      Post myPosts = Post.fromMap(postQuery.docs[index].data() as Map<String,dynamic>);
                      DocumentReference post = FirebaseFirestore.instance.collection('users').doc(widget.userModel.uid).collection('posts').doc(myPosts.postId);
                      return Column(
                        children: [
                          const Divider(
                            color: Colors.grey,
                            thickness: 0.1,
                          ),
                          Card(
                            color: Colors.black,
                            elevation: 0,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          myPosts.profilePic ?? "",
                                        ),
                                        radius: 15,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        myPosts.userName ?? "",
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.more_vert,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onDoubleTap: () {},
                                  child: PinchZoomReleaseUnzoomWidget(
                                    child: InstaLikeButton(
                                      height: height / 2 + height / 12,
                                      iconSize: 100,
                                      image: NetworkImage(
                                        myPosts.images?[0] ?? '',
                                      ),
                                      onChanged: () {
                                        setState(() {
                                          if (myPosts.liked == false) {
                                            post.update({'liked':true});
                                            post.update({'likes':FieldValue.increment(1)});
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width/20,
                                    ),
                                    if (myPosts.liked == true)
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            post.update({'liked':false});
                                            post.update({'likes':FieldValue.increment(-1)});
                                          });
                                        },
                                        child: const SizedBox(
                                          height: 27,
                                          width: 27,
                                          child: Image(
                                            image: AssetImage('assets/Icons/Loved.png'),
                                          ),
                                        ),
                                      )
                                    else
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            post.update({'liked':true});
                                            post.update({'likes':FieldValue.increment(1)});
                                          });
                                        },
                                        child: const SizedBox(
                                          height: 27,
                                          width: 27,
                                          child: Image(
                                            image: AssetImage('assets/Icons/love.png'),
                                          ),
                                        ),
                                      ),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          child: Container(
                                            height: 32,
                                            width: 32,
                                            child: const Image(
                                              image:
                                              AssetImage('assets/Icons/chat.png'),
                                            ),
                                          ),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        child: InkWell(
                                          child: Container(
                                            height: 25,
                                            width: 25,
                                            child: const Image(
                                              image:
                                              AssetImage('assets/Icons/send.png'),
                                            ),
                                          ),
                                        )),
                                    const Spacer(),
                                    Container(
                                      height: 25,
                                      width: 25,
                                      child: const Image(
                                        image: AssetImage('assets/Icons/Saved.png'),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/20, 0, 0, 0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${myPosts.likes} likes',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/20, 0, 0, 0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: ExpandableText(
                                      text:
                                      '${myPosts.userName} ${myPosts.description}',
                                      maxLines:
                                      3, // Set the number of lines before the "more" button appears
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    childCount: postQuery.docs.length
                    ,
                  ),
                );
              }
              else if(snapshot.hasError){
                return SliverList(delegate: SliverChildListDelegate([]));
              }
              else{
                return SliverList(delegate: SliverChildListDelegate([]));
              }
            }
          ),
        ],
      );
  }
}
