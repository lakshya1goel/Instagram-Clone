import 'package:animated_dashed_circle/animated_dashed_circle.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Services/home_story.dart';
import 'package:insta_clone/Services/post.dart';
import 'package:insta_clone/Utils/expandable_text.dart';
import 'Stories.dart';

class HomePage extends StatefulWidget {
  // final String username;
  HomePage({super.key});

  final List<post> posts = [
    post(UserName: '43.paras.57', Likes: 52, Description: 'hey its my new pic', Image: 'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1365&q=80', ProfilePic: 'https://instagram.fagr1-3.fna.fbcdn.net/v/t51.2885-19/340046144_1573819893114923_1993567904210653388_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.fagr1-3.fna.fbcdn.net&_nc_cat=111&_nc_ohc=OimvTRSrIeUAX_H8GIg&edm=ACWDqb8BAAAA&ccb=7-5&oh=00_AfBzB8cbLWkBcrgg6UcZON6FVX_LGJL_kw3TvtbsRB3Q-g&oe=64BD7F89&_nc_sid=ee9879'),
    post(UserName: '43.paras.57', Likes: 52, Description: 'hey its my new pic hey its my new pic hey its my new pic hey its my new pic hey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pic', Image: 'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1365&q=80', ProfilePic: 'https://instagram.fagr1-3.fna.fbcdn.net/v/t51.2885-19/340046144_1573819893114923_1993567904210653388_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.fagr1-3.fna.fbcdn.net&_nc_cat=111&_nc_ohc=OimvTRSrIeUAX_H8GIg&edm=ACWDqb8BAAAA&ccb=7-5&oh=00_AfBzB8cbLWkBcrgg6UcZON6FVX_LGJL_kw3TvtbsRB3Q-g&oe=64BD7F89&_nc_sid=ee9879'),
    post(UserName: '43.paras.57', Likes: 52, Description: 'hey its my new pic', Image: 'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1365&q=80', ProfilePic: 'https://instagram.fagr1-3.fna.fbcdn.net/v/t51.2885-19/340046144_1573819893114923_1993567904210653388_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.fagr1-3.fna.fbcdn.net&_nc_cat=111&_nc_ohc=OimvTRSrIeUAX_H8GIg&edm=ACWDqb8BAAAA&ccb=7-5&oh=00_AfBzB8cbLWkBcrgg6UcZON6FVX_LGJL_kw3TvtbsRB3Q-g&oe=64BD7F89&_nc_sid=ee9879')

  ];
  List<home_story> stories = [
    home_story(Imgae: 'https://bit.ly/43IEnby', username: '43.paras.57-1', seen: false),
    home_story(Imgae: 'https://bit.ly/43IEnby', username: '43.paras.57-2', seen: false),
    home_story(Imgae: 'https://bit.ly/43IEnby', username: '43.paras.57-3', seen: false),
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: CustomScrollView(
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
                      image: AssetImage('assets/Icons/heart.png'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 25,
                    width: 25,
                    child: const Image(
                      image: AssetImage('assets/Icons/send.png'),
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
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.stories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: ()async{
                                   await Navigator.push(context, MaterialPageRoute(builder: (context)=>StoriesPage(selected_page: index, status: widget.stories)));
                                    setState(() {
                                      home_story My_story = widget.stories[0];
                                      List<home_story> remainingItems = List.from(widget.stories.sublist(1));
                                      remainingItems.sort((a, b) => a.seen ? 1 : -1);
                                      widget.stories = [My_story, ...remainingItems];
                                    });

                                  },
                                  child: CircleAvatar(
                                    radius: 45,
                                    child: Container(
                                      decoration: !widget.stories[index].seen ? const BoxDecoration(
                                        shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [Color(0xFF9B2282),Color(0xFFEEA863)]
                                          )
                                      ) : BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey[700]
                                      ),
                                      child: CircleAvatar(
                                        radius: !widget.stories[index].seen ?45:45.2,
                                        backgroundColor: Colors.transparent,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.black,
                                          radius: !widget.stories[index].seen ?42.5:43.6,
                                          child: Stack(
                                            children: [
                                              CircleAvatar(
                                                radius: 40,
                                                backgroundImage: NetworkImage(widget.stories[index].Imgae),
                                              ),
                                              index == 0?Positioned(
                                                left: 55,
                                                top: 55,
                                                child: Icon(
                                                    Icons.add_circle,
                                                  color: Colors.blue,
                                                ),
                                              ):SizedBox()
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ),
                              ),
                              Text(
                                widget.stories[index].username,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
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
                                      widget.posts[index].ProfilePic,
                                    ),
                                    radius: 15,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    widget.posts[index].UserName,
                                    style: const TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                            Image(
                              image: NetworkImage(
                                widget.posts[index].Image,
                              ),
                            ),
                             Row(
                              children: [
                                 const SizedBox(width: 5,),
                                 const Padding(
                                  padding:  EdgeInsets.all(8.0),
                                  child: InkWell(
                                    child: SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: Image(
                                        image: AssetImage('assets/Icons/heart.png'),
                                      ),
                                    ),
                                  )
                                ),
                                 Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      child: const Image(
                                        image: AssetImage('assets/Icons/chat.png'),
                                      ),
                                    ),
                                  )
                                ),
                                 Padding(
                                  padding:  const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    child: Container(
                                      height: 25,
                                      width: 25,
                                      child: const Image(
                                        image: AssetImage('assets/Icons/send.png'),
                                      ),
                                    ),
                                  )
                                ),
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
                              padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${widget.posts[index].Likes} likes',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: ExpandableText(
                                  text: '${widget.posts[index].UserName} ${widget.posts[index].Description}',
                                  maxLines: 3, // Set the number of lines before the "more" button appears
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
                childCount: widget.posts.length,
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              label: '',
              icon: Container(
                height: 20,
                width: 20,
                child: const Image(
                  image: AssetImage('assets/Icons/home.png'),
                ),
              ),
            ),
            const BottomNavigationBarItem(
              label: '',
              icon: SizedBox(
                height: 20,
                width: 20,
                child: Image(
                  image: AssetImage('assets/Icons/search.png'),
                ),
              ),
            ),
            const BottomNavigationBarItem(
              label: '',
              icon: SizedBox(
                height: 20,
                width: 20,
                child:  Image(
                  image: AssetImage('assets/Icons/upload.png'),
                ),
              ),
            ),
           const  BottomNavigationBarItem(
              label: '',
              icon: SizedBox(
                height: 20,
                width: 20,
                child: Image(
                  image: AssetImage('assets/Icons/Reels.png'),
                ),
              ),
            ),
            const BottomNavigationBarItem(
              label: '',
              icon: CircleAvatar(
                backgroundImage: NetworkImage('https://bit.ly/43IEnby'),
                radius: 15,
              )
            ),
          ],
        ),
      ),
    );
  }
}