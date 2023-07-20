import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  List<dynamic> posts = [];
  List<dynamic> stories = [];

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
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 90,
              floating: true,
              snap: true,
              title: Row(
                children: [
                  SizedBox(width: 10),
                  Image(
                    height: 80,
                    width: 160,
                    image: AssetImage(
                      'assets/images/home_page/instagram.png',
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      print(
                          '--------------------------------------------------------------------------------------------------------hello');
                    },
                    icon: Icon(
                      Icons.notifications,
                      size: 25,
                    ),
                  ),
                  SizedBox(width: 20),
                  Transform.rotate(
                    angle: -45 * (3.14 / 180),
                    child: Icon(
                      Icons.send_sharp,
                      size: 25,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.transparent,
            ),
          ],
          body: Column(
            children: [
              // TODO make a basic story viewing layout
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.stories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: widget.stories[index].image,
                              ),
                              Text(widget.stories[index].username),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.posts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      // TODO Add the content for each post here
                    );
                  },
                ),
              ),
            ],
          ),
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
