import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Models/UserModel.dart';
import 'package:insta_clone/Pages/authentication/login/login_page.dart';
import 'package:insta_clone/Services/profile_accounts.dart';
import 'package:insta_clone/Services/profile_highlight.dart';
import 'package:insta_clone/Services/create_items.dart';
class Profile extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  Profile({Key? key, required this.userModel, required this.firebaseUser}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              pinned: true,
              title: Row(
                children: [
                  Text(
                    widget.userModel.username.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                      onPressed: (){
                        _bottomSheet2(context);
                      },
                      icon: Icon(Icons.keyboard_arrow_down)),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    _bottomSheet1(context);
                  },
                  icon: const Icon(Icons.add_box_outlined),
                ),
                IconButton(
                  onPressed: () {
                    _bottomSheet3(context);
                  },
                  icon: const Icon(Icons.dehaze_outlined),
                ),
              ],
            ),
            SliverToBoxAdapter(child: ProfileHeader(userModel: widget.userModel, firebaseUser: widget.firebaseUser)),
            SliverPersistentHeader(
              pinned: true,
              delegate: ProfileTabbar(
                child: Container(
                  color: Colors.black,
                  child: TabBar(
                    labelColor: Colors.white,
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(
                        icon: Icon(Icons.grid_on),
                      ),
                      Tab(
                        icon: Image.asset('assets/Icons/Reels.png',
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                      Tab(
                        icon: Icon(Icons.assignment_ind_outlined),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          body: const TabBarView(
            children: [
              _ProfileGridView(),
              _ProfileGridView1(),
              _ProfileGridView1(),
            ],
          ),
        ),
      ),
    );
  }
}


class ProfileHeader extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  ProfileHeader({Key? key, required this.userModel, required this.firebaseUser});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration:BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(widget.userModel.profilePic.toString()),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:  [
                    Column(
                      children: [
                        Text(
                          "11",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white
                          ),
                        ),
                        Text("Posts",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "4,710",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white
                          ),
                        ),
                        Text("Followers",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "150",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white
                          ),
                        ),
                        Text("Following",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.userModel.name.toString(),
                style: TextStyle(
                    color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(widget.userModel.bio.toString(),
                style: TextStyle(
                    color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 164.0,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context){
                              return EditProfile(userModel: widget.userModel, firebaseUser: widget.firebaseUser,);
                            }
                        ));
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey[850],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0,),
                  SizedBox(
                    width: 164.0,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey[850],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                          "Share Profile",
                          style: TextStyle(
                              color: Colors.white
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          _StoryHighlights(),
        ],
      ),
    );
  }
}

class EditProfile extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  EditProfile({Key? key, required this.userModel, required this.firebaseUser}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: widget.userModel.name.toString());
    final TextEditingController usernameController = TextEditingController(text: widget.userModel.username.toString());
    final TextEditingController pronounController = TextEditingController();
    final TextEditingController bioController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Edit Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.check,
              color: Colors.blue,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 35.0,),
          Center(
            child: CircleAvatar(
              radius: 40.0,
              backgroundImage: NetworkImage(widget.userModel.profilePic.toString()),
            ),
          ),
          Center(
            child: TextButton(
                onPressed: (){},
                child: Text("Edit picture",
                  style: TextStyle(color: Colors.blue),
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                TextFormField(
                  controller: usernameController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: "Username",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                TextFormField(
                  controller: pronounController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: "Pronouns",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                TextFormField(
                  controller: bioController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: "Bio",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class _StoryHighlights extends StatefulWidget {
  const _StoryHighlights({super.key});

  @override
  State<_StoryHighlights> createState() => _StoryHighlightsState();
}

class _StoryHighlightsState extends State<_StoryHighlights> {
  int currentHighlightIndex = 0;
  List<profile_highlight> tiles=[
    profile_highlight(desc: "My pics", image: 'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1365&q=80'),
    profile_highlight(desc: "Hehe", image: 'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/825fb915-d6a8-4bd2-ba12-ba661266a6f9/dfndnu7-e10d71e6-3427-4bda-a7f1-8dc8a55fb968.png/v1/fill/w_894,h_894,q_70,strp/bigred_cute_anime_boy_with_black_hair_and_big_blue_by_sketchesbydani_dfndnu7-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTAyNCIsInBhdGgiOiJcL2ZcLzgyNWZiOTE1LWQ2YTgtNGJkMi1iYTEyLWJhNjYxMjY2YTZmOVwvZGZuZG51Ny1lMTBkNzFlNi0zNDI3LTRiZGEtYTdmMS04ZGM4YTU1ZmI5NjgucG5nIiwid2lkdGgiOiI8PTEwMjQifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.8v_PPYlfNxvYxB4wNAtsR4TPaGugUJcqnx6SSJLEWTU'),
    profile_highlight(desc: "Bye", image: 'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1365&q=80'),
    profile_highlight(desc: "My pics1", image: 'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/825fb915-d6a8-4bd2-ba12-ba661266a6f9/dfndnu7-e10d71e6-3427-4bda-a7f1-8dc8a55fb968.png/v1/fill/w_894,h_894,q_70,strp/bigred_cute_anime_boy_with_black_hair_and_big_blue_by_sketchesbydani_dfndnu7-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTAyNCIsInBhdGgiOiJcL2ZcLzgyNWZiOTE1LWQ2YTgtNGJkMi1iYTEyLWJhNjYxMjY2YTZmOVwvZGZuZG51Ny1lMTBkNzFlNi0zNDI3LTRiZGEtYTdmMS04ZGM4YTU1ZmI5NjgucG5nIiwid2lkdGgiOiI8PTEwMjQifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.8v_PPYlfNxvYxB4wNAtsR4TPaGugUJcqnx6SSJLEWTU'),
    profile_highlight(desc: "Hehe1", image: 'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1365&q=80'),
    profile_highlight(desc: "Bye1", image: 'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/825fb915-d6a8-4bd2-ba12-ba661266a6f9/dfndnu7-e10d71e6-3427-4bda-a7f1-8dc8a55fb968.png/v1/fill/w_894,h_894,q_70,strp/bigred_cute_anime_boy_with_black_hair_and_big_blue_by_sketchesbydani_dfndnu7-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTAyNCIsInBhdGgiOiJcL2ZcLzgyNWZiOTE1LWQ2YTgtNGJkMi1iYTEyLWJhNjYxMjY2YTZmOVwvZGZuZG51Ny1lMTBkNzFlNi0zNDI3LTRiZGEtYTdmMS04ZGM4YTU1ZmI5NjgucG5nIiwid2lkdGgiOiI8PTEwMjQifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.8v_PPYlfNxvYxB4wNAtsR4TPaGugUJcqnx6SSJLEWTU'),
  ];

  void _showFullScreenImage(List<profile_highlight> highlights, int currentIndex) {
    setState(() {
      currentHighlightIndex = currentIndex;
    });
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: GestureDetector(
              onTapUp: (details) {
                double screenWidth = MediaQuery.of(context).size.width;
                double tapX = details.globalPosition.dx;
                double tapRatio = tapX / screenWidth;
                double threshold = 0.5;
                if (tapRatio < threshold && currentIndex!=0) {
                  _showPreviousImage();
                } else if((tapRatio > threshold && currentIndex!=tiles.length-1)){
                  _showNextImage();
                }
                else{
                  Navigator.of(context).pop();
                }
              },
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity! < 0) {
                  _showNextImage();
                } else if (details.primaryVelocity! > 0) {
                  _showPreviousImage();
                }
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(highlights[currentIndex].image),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        highlights[currentIndex].desc,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Hero(
                      tag: highlights[currentIndex].image,
                      child: Image.network(highlights[currentIndex].image),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  void _showPreviousImage() {
    if (currentHighlightIndex > 0) {
      _showFullScreenImage(tiles, currentHighlightIndex - 1);
    }
  }

  void _showNextImage() {
    if (currentHighlightIndex < tiles.length - 1) {
      _showFullScreenImage(tiles, currentHighlightIndex + 1);
    }
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: tiles.length,
        itemBuilder: (BuildContext context, int index) {
          final highlight = tiles[index];
          return Container(
            margin: const EdgeInsets.only(right: 12.0),
            child: Column(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _showFullScreenImage(tiles, index),
                    child: Container(
                      height: 62,
                      width: 62,
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                          border: Border.all(color: Colors.grey),
                          image: DecorationImage(
                            image: NetworkImage(highlight.image),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  highlight.desc,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void _bottomSheet1(context){
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
    ),
    context: context,
    builder: (BuildContext icon) {
      return Create();
      },
  );
}
class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  List<create_items>items=[
    create_items(icon: Icon(Icons.account_circle,
    color: Colors.white,), name: "Reel"),
    create_items(icon: Icon(Icons.account_circle,
    color: Colors.white,), name: "Post"),
    create_items(icon: Icon(Icons.account_circle,
    color: Colors.white,), name: "Story"),
    create_items(icon: Icon(Icons.account_circle,
    color: Colors.white,), name: "Story Highlight"),
    create_items(icon: Icon(Icons.account_circle,
    color: Colors.white,), name: "Live"),
    create_items(icon: Icon(Icons.account_circle,
    color: Colors.white,), name: "Guide"),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xDD000000),
      height: 500.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Center(
              child: Container(height: 4.0,width: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Center(
              child: Text(
                "Create",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Divider(thickness:0.2,color: Colors.grey),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: ()async{
                    print('hello');
                    await FirebaseAuth.instance.signOut();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                  },
                  leading: items[index].icon,
                  title: Text(items[index].name,
                  style: TextStyle(
                    color: Colors.white
                  ),),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


void _bottomSheet2(context){
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


void _bottomSheet3(context){
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
    ),
    context: context,
    builder: (BuildContext icon) {
      return profile_more_options();
    },
  );
}
class profile_more_options extends StatefulWidget {
  const profile_more_options({super.key});

  @override
  State<profile_more_options> createState() => _profile_more_optionsState();
}

class _profile_more_optionsState extends State<profile_more_options> {
  List<create_items>items=[
    create_items(icon: Icon(Icons.account_circle,
      color: Colors.white,), name: "Settings and privacy"),
    create_items(icon: Icon(Icons.account_circle,
      color: Colors.white,), name: "Threas"),
    create_items(icon: Icon(Icons.account_circle,
      color: Colors.white,), name: "Your activity"),
    create_items(icon: Icon(Icons.account_circle,
      color: Colors.white,), name: "Archive"),
    create_items(icon: Icon(Icons.account_circle,
      color: Colors.white,), name: "QR code"),
    create_items(icon: Icon(Icons.account_circle,
      color: Colors.white,), name: "Saved"),
    create_items(icon: Icon(Icons.account_circle,
      color: Colors.white,), name: "Meta Verified"),
    create_items(icon: Icon(Icons.account_circle,
      color: Colors.white,), name: "Close Friends"),
    create_items(icon: Icon(Icons.account_circle,
      color: Colors.white,), name: "Favourites"),
    create_items(icon: Icon(Icons.account_circle,
      color: Colors.white,), name: "Discover people"),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xDD000000),
      height: 700.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.0),
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
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: items[index].icon,
                  title: Text(items[index].name,
                    style: TextStyle(
                        color: Colors.white
                    ),),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileTabbar extends SliverPersistentHeaderDelegate {
  final Widget child;

  ProfileTabbar({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 48;

  @override
  // TODO: implement minExtent
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class _ProfileGridView extends StatefulWidget {
  const _ProfileGridView({super.key});

  @override
  State<_ProfileGridView> createState() => _ProfileGridViewState();
}

class _ProfileGridViewState extends State<_ProfileGridView> {
  List<String>posts=[
    'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/825fb915-d6a8-4bd2-ba12-ba661266a6f9/dfndnu7-e10d71e6-3427-4bda-a7f1-8dc8a55fb968.png/v1/fill/w_894,h_894,q_70,strp/bigred_cute_anime_boy_with_black_hair_and_big_blue_by_sketchesbydani_dfndnu7-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTAyNCIsInBhdGgiOiJcL2ZcLzgyNWZiOTE1LWQ2YTgtNGJkMi1iYTEyLWJhNjYxMjY2YTZmOVwvZGZuZG51Ny1lMTBkNzFlNi0zNDI3LTRiZGEtYTdmMS04ZGM4YTU1ZmI5NjgucG5nIiwid2lkdGgiOiI8PTEwMjQifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.8v_PPYlfNxvYxB4wNAtsR4TPaGugUJcqnx6SSJLEWTU',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1365&q=80',
    'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/825fb915-d6a8-4bd2-ba12-ba661266a6f9/dfndnu7-e10d71e6-3427-4bda-a7f1-8dc8a55fb968.png/v1/fill/w_894,h_894,q_70,strp/bigred_cute_anime_boy_with_black_hair_and_big_blue_by_sketchesbydani_dfndnu7-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTAyNCIsInBhdGgiOiJcL2ZcLzgyNWZiOTE1LWQ2YTgtNGJkMi1iYTEyLWJhNjYxMjY2YTZmOVwvZGZuZG51Ny1lMTBkNzFlNi0zNDI3LTRiZGEtYTdmMS04ZGM4YTU1ZmI5NjgucG5nIiwid2lkdGgiOiI8PTEwMjQifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.8v_PPYlfNxvYxB4wNAtsR4TPaGugUJcqnx6SSJLEWTU',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1365&q=80',
    'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/825fb915-d6a8-4bd2-ba12-ba661266a6f9/dfndnu7-e10d71e6-3427-4bda-a7f1-8dc8a55fb968.png/v1/fill/w_894,h_894,q_70,strp/bigred_cute_anime_boy_with_black_hair_and_big_blue_by_sketchesbydani_dfndnu7-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTAyNCIsInBhdGgiOiJcL2ZcLzgyNWZiOTE1LWQ2YTgtNGJkMi1iYTEyLWJhNjYxMjY2YTZmOVwvZGZuZG51Ny1lMTBkNzFlNi0zNDI3LTRiZGEtYTdmMS04ZGM4YTU1ZmI5NjgucG5nIiwid2lkdGgiOiI8PTEwMjQifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.8v_PPYlfNxvYxB4wNAtsR4TPaGugUJcqnx6SSJLEWTU',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1365&q=80',
    'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/825fb915-d6a8-4bd2-ba12-ba661266a6f9/dfndnu7-e10d71e6-3427-4bda-a7f1-8dc8a55fb968.png/v1/fill/w_894,h_894,q_70,strp/bigred_cute_anime_boy_with_black_hair_and_big_blue_by_sketchesbydani_dfndnu7-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTAyNCIsInBhdGgiOiJcL2ZcLzgyNWZiOTE1LWQ2YTgtNGJkMi1iYTEyLWJhNjYxMjY2YTZmOVwvZGZuZG51Ny1lMTBkNzFlNi0zNDI3LTRiZGEtYTdmMS04ZGM4YTU1ZmI5NjgucG5nIiwid2lkdGgiOiI8PTEwMjQifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.8v_PPYlfNxvYxB4wNAtsR4TPaGugUJcqnx6SSJLEWTU',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1365&q=80',
    'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/825fb915-d6a8-4bd2-ba12-ba661266a6f9/dfndnu7-e10d71e6-3427-4bda-a7f1-8dc8a55fb968.png/v1/fill/w_894,h_894,q_70,strp/bigred_cute_anime_boy_with_black_hair_and_big_blue_by_sketchesbydani_dfndnu7-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTAyNCIsInBhdGgiOiJcL2ZcLzgyNWZiOTE1LWQ2YTgtNGJkMi1iYTEyLWJhNjYxMjY2YTZmOVwvZGZuZG51Ny1lMTBkNzFlNi0zNDI3LTRiZGEtYTdmMS04ZGM4YTU1ZmI5NjgucG5nIiwid2lkdGgiOiI8PTEwMjQifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.8v_PPYlfNxvYxB4wNAtsR4TPaGugUJcqnx6SSJLEWTU',
    'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/825fb915-d6a8-4bd2-ba12-ba661266a6f9/dfndnu7-e10d71e6-3427-4bda-a7f1-8dc8a55fb968.png/v1/fill/w_894,h_894,q_70,strp/bigred_cute_anime_boy_with_black_hair_and_big_blue_by_sketchesbydani_dfndnu7-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTAyNCIsInBhdGgiOiJcL2ZcLzgyNWZiOTE1LWQ2YTgtNGJkMi1iYTEyLWJhNjYxMjY2YTZmOVwvZGZuZG51Ny1lMTBkNzFlNi0zNDI3LTRiZGEtYTdmMS04ZGM4YTU1ZmI5NjgucG5nIiwid2lkdGgiOiI8PTEwMjQifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.8v_PPYlfNxvYxB4wNAtsR4TPaGugUJcqnx6SSJLEWTU'
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        final post = posts[index];
        return Container(
          color: Colors.grey,
          child: Image.network(
            post,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}

class _ProfileGridView1 extends StatefulWidget {
  const _ProfileGridView1({super.key});

  @override
  State<_ProfileGridView1> createState() => _ProfileGridView1State();
}

class _ProfileGridView1State extends State<_ProfileGridView1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "Nothing to show",
          style: TextStyle(
              color: Colors.grey,
              fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}











