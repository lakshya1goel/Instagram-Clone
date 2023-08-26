import 'dart:async';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/Models/UserModel.dart';
import 'package:insta_clone/Pages/home/Story/home_page_story.dart';
import 'package:insta_clone/Pages/home/chatting_system/chat_contacts.dart';
import 'package:insta_like_button/insta_like_button.dart';
import 'package:insta_clone/Services/Home/post.dart';
import 'package:insta_clone/Utils/expandable_text.dart';
import 'package:pinch_zoom_release_unzoom/pinch_zoom_release_unzoom.dart';
import 'Story/home_story.dart';
import 'Story/story.dart';
import 'Story/story_view.dart';

class HomePage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  HomePage({Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);
  final List<Post> posts = [];
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<StoryModel> stories = [];

  Future<List<StoryModel>> getUsersWithStories() async {
    final usersSnapshot =
    await FirebaseFirestore.instance.collection('users').get();

    final usersWithStories =
    await Future.wait(usersSnapshot.docs.map((userDoc) async {
      final storiesSnapshot =
      await userDoc.reference.collection('stories').get();

      if (storiesSnapshot.docs.isNotEmpty) {
        final stories = storiesSnapshot.docs.map((storyDoc) {
          final storyData = storyDoc.data();
          return StoryPageModel.fromMap(storyData);
        }).toList();

        return StoryModel(
          storyModelUserName: userDoc.data()['username'],
          storyModelProfilePic: userDoc.data()['profilePic'],
          storyModelUserStories: stories, uid: widget.userModel.uid,
        );
      } else {
        return null;
      }
    }));

    final filteredStories =
    usersWithStories.where((user) => user != null).toList();

    stories = filteredStories.cast<StoryModel>();
    return stories;
  }

  void reorderStories() {
    final userStoryIndex = stories.indexWhere(
            (story) => story.storyModelUserName == widget.userModel.uid);

    if (userStoryIndex != -1) {
      // Logged-in user's story exists, reorder the list
      final userStory = stories.removeAt(userStoryIndex);
      stories.insert(0, userStory);
    } else {
      // Logged-in user's story doesn't exist, create a new element
      final newUserStory = StoryModel(
        storyModelUserName: widget.userModel.username,
        storyModelProfilePic: widget.userModel.profilePic,
        storyModelUserStories: [], uid: widget.userModel.uid, // Add empty list of stories
      );
      stories.insert(0, newUserStory);
    }
  }

  @override
  void initState() {
    super.initState();
    getUsersWithStories();
    reorderStories();
  }

  @override
  Widget build(BuildContext context) {
    Stream<List<StoryModel>> storyStream =
    Stream.fromFuture(getUsersWithStories());
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
              const SizedBox(
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
                      MaterialPageRoute(
                          builder: (context) => ChatContact(
                            userModel: widget.userModel,
                            firebaseUser: widget.firebaseUser,
                          )),
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
        StreamBuilder<Object>(
            stream: storyStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverList(delegate: SliverChildListDelegate([]));
              } else if (snapshot.hasError) {
                return SliverList(delegate: SliverChildListDelegate([]));
              } else if (!snapshot.hasData) {
                return const Text('No stories available.');
              } else {
                return SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(
                        height: height * 0.107,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: stories.length,
                          itemBuilder: (BuildContext context, int index) {
                            print(stories.length);
                            return Stack(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: index == 0
                                          ? EdgeInsets.fromLTRB(20, 0, 0, 0)
                                          : EdgeInsets.fromLTRB(15, 0, 0, 0),
                                      child: InkWell(
                                          onTap: () async {
                                            if(stories[0].storyModelUserStories!.isEmpty){
                                            }
                                            else{
                                              await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => StoriesPage(
                                                          selectedPage: index,
                                                          status: stories[index]
                                                              .storyModelUserStories!,
                                                          stories: stories)));
                                            }
                                          },
                                          child: CircleAvatar(
                                            radius: StorySize,
                                            child: Container(
                                              decoration: !stories[0]
                                                  .storyModelUserStories![0]
                                                  .seen!
                                                  ? const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  gradient: LinearGradient(
                                                      begin:
                                                      Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                        Color(0xFF9B2282),
                                                        Color(0xFFEEA863)
                                                      ]))
                                                  : BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey[700]),
                                              child: CircleAvatar(
                                                radius: !stories[0]
                                                    .storyModelUserStories![0]
                                                    .seen!
                                                    ? StorySize
                                                    : StorySize + 0.2,
                                                backgroundColor: Colors.transparent,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.black,
                                                  radius: !stories[0]
                                                      .storyModelUserStories![0]
                                                      .seen!
                                                      ? StorySize - 2.5
                                                      : StorySize - 1.5,
                                                  child: CircleAvatar(
                                                    radius: StorySize - 5,
                                                    backgroundImage:
                                                    NetworkImage(stories[
                                                    index]
                                                        .storyModelProfilePic!),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(15, 4, 0, 0),
                                      child: Text(
                                        stories[index].storyModelUserName ?? '',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                                if(index == 0)Positioned(
                                  top: 43,
                                  left: 65,
                                  child: CircleAvatar(
                                    radius: 10,
                                    child: IconButton(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        padding: EdgeInsets.fromLTRB(0, 0, 0,0),
                                        onPressed: () async {
                                          XFile? image = await ImagePicker()
                                              .pickImage(
                                              source:
                                              ImageSource.gallery);
                                          UploadStory(
                                              story: image,
                                              user: widget.userModel)
                                              .uploadStory(context);
                                        }, icon: const Icon(Icons.add,size: 16,color: Colors.white,)),
                                  ),
                                )
                                else SizedBox(),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
          StreamBuilder<Object>(
            stream: FirebaseFirestore.instance.collectionGroup('posts').snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                QuerySnapshot postQuery = snapshot.data as QuerySnapshot;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      Post allPosts = Post.fromMap(postQuery.docs[index].data() as Map<String,dynamic>);
                      DocumentReference post = FirebaseFirestore.instance.collection('users').doc(allPosts.userId).collection('posts').doc(allPosts.postId);
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
                                          allPosts.profilePic ?? "",
                                        ),
                                        radius: 15,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        allPosts.userName ?? "",
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: (){
                                            showDialog(context: context, builder: (BuildContext context){
                                              return AlertDialog(
                                                title: Text('Delete karna hai kya isko'),
                                                actions: [
                                                  TextButton(onPressed: (){
                                                    Navigator.pop(context);
                                                    if(allPosts.userId == widget.userModel.uid){
                                                      post.delete();
                                                    }
                                                    else{
                                                      showDialog(
                                                        context: context,
                                                        builder:(BuildContext context){
                                                          return AlertDialog(
                                                            title: Text('Bhkk apni post delete kar saale'),
                                                            actions: [
                                                              TextButton(onPressed:()=> {Navigator.pop(context)}, child: Text('Han han thik hai'))
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    }
                                                  }, child: Text('Han kar de yarr')),
                                                  TextButton(onPressed: (){
                                                    Navigator.pop(context);
                                                  }, child: Text('chodd pade rehne de')),
                                                ],
                                              );
                                            });
                                          },
                                          icon: Icon(
                                            Icons.more_vert,
                                            color: Colors.white,
                                          )
                                      )
                                    ],
                                  ),
                                ),
                                ImageSlideshow(
                                  height: height / 2 + height / 12,
                                  indicatorBackgroundColor: Colors.grey,
                                  indicatorColor: Colors.white,
                                  children: allPosts.images?.map((imageURL) {
                                    return PinchZoomReleaseUnzoomWidget(
                                      child: InstaLikeButton(
                                        height: height / 2 + height / 12,
                                        iconSize: 100,
                                        image: NetworkImage(imageURL),
                                        onChanged: () {
                                          setState(() {
                                            if (allPosts.liked == false) {
                                              post.update({'liked': true});
                                              post.update({'likes': FieldValue.increment(1)});
                                            }
                                          });
                                        },
                                      ),
                                    );
                                  }).toList() ?? [], // Convert the mapped Iterable to a List
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width/20,
                                    ),
                                    if (allPosts.liked == true)
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
                                      '${allPosts.likes} likes',
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
                                      '${allPosts.userName} ${allPosts.description}',
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
