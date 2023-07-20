import 'package:flutter/material.dart';
import 'package:insta_clone/Services/post.dart';
import 'package:insta_clone/Services/story.dart';
import 'package:insta_clone/Utils/expandable_text.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  List<post> posts = [
    post(UserName: '43.paras.57', Likes: 52, Description: 'hey its my new pic', Image: 'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1365&q=80', ProfilePic: 'https://instagram.fagr1-3.fna.fbcdn.net/v/t51.2885-19/340046144_1573819893114923_1993567904210653388_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.fagr1-3.fna.fbcdn.net&_nc_cat=111&_nc_ohc=OimvTRSrIeUAX_H8GIg&edm=ACWDqb8BAAAA&ccb=7-5&oh=00_AfBzB8cbLWkBcrgg6UcZON6FVX_LGJL_kw3TvtbsRB3Q-g&oe=64BD7F89&_nc_sid=ee9879'),
    post(UserName: '43.paras.57', Likes: 52, Description: 'hey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pichey its my new pic', Image: 'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1365&q=80', ProfilePic: 'https://instagram.fagr1-3.fna.fbcdn.net/v/t51.2885-19/340046144_1573819893114923_1993567904210653388_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.fagr1-3.fna.fbcdn.net&_nc_cat=111&_nc_ohc=OimvTRSrIeUAX_H8GIg&edm=ACWDqb8BAAAA&ccb=7-5&oh=00_AfBzB8cbLWkBcrgg6UcZON6FVX_LGJL_kw3TvtbsRB3Q-g&oe=64BD7F89&_nc_sid=ee9879'),
    post(UserName: '43.paras.57', Likes: 52, Description: 'hey its my new pic', Image: 'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1365&q=80', ProfilePic: 'https://instagram.fagr1-3.fna.fbcdn.net/v/t51.2885-19/340046144_1573819893114923_1993567904210653388_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.fagr1-3.fna.fbcdn.net&_nc_cat=111&_nc_ohc=OimvTRSrIeUAX_H8GIg&edm=ACWDqb8BAAAA&ccb=7-5&oh=00_AfBzB8cbLWkBcrgg6UcZON6FVX_LGJL_kw3TvtbsRB3Q-g&oe=64BD7F89&_nc_sid=ee9879')

  ];
  List<story> stories = [
    story(Image: 'https://instagram.fagr1-3.fna.fbcdn.net/v/t51.2885-19/340046144_1573819893114923_1993567904210653388_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.fagr1-3.fna.fbcdn.net&_nc_cat=111&_nc_ohc=OimvTRSrIeUAX_H8GIg&edm=ACWDqb8BAAAA&ccb=7-5&oh=00_AfBzB8cbLWkBcrgg6UcZON6FVX_LGJL_kw3TvtbsRB3Q-g&oe=64BD7F89&_nc_sid=ee9879', UserName: 'Your Story')
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
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications,
                      size: 25,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Transform.rotate(
                    angle: -45 * (3.14 / 180),
                    child: const Icon(
                      Icons.send_sharp,
                      size: 25,
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
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.stories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.pink,
                                  radius: 30,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: 28,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(widget.stories[index].Image),
                                      radius: 25,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                widget.stories[index].UserName,
                                style: const TextStyle(
                                    color: Colors.white
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
                      Divider(
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
                                  SizedBox(width: 5),
                                  Text(
                                    widget.posts[index].UserName,
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.settings, // TODO: 3 dots ka icon lagega
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Icon(
                                    Icons.favorite_border,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.comment,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Transform.rotate(
                                    angle: -45 * (3.14 / 180),
                                    child: const Icon(
                                      Icons.send_sharp,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                const Icon(
                                  Icons.save_alt,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${widget.posts[index].Likes} likes',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ExpandableText(
                                text: widget.posts[index].Description,
                                maxLines: 3, // Set the number of lines before the "more" button appears
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
          items: const [
            BottomNavigationBarItem(
              label: 'ICON1',
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            BottomNavigationBarItem(
              label: 'ICON2',
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            BottomNavigationBarItem(
              label: 'ICON3',
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            BottomNavigationBarItem(
              label: 'ICON4',
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            BottomNavigationBarItem(
              label: 'ICON5',
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
