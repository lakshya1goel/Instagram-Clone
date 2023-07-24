import 'package:flutter/material.dart';
import 'package:insta_clone/Services/profile_highlight.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

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
            const _InstagramProfileAppBar(),
            const SliverToBoxAdapter(child: ProfileHeader()),
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
              _ProfileGridView(),
              _ProfileGridView(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileGridView extends StatefulWidget {
  const _ProfileGridView({super.key});

  @override
  State<_ProfileGridView> createState() => _ProfileGridViewState();
}

class _ProfileGridViewState extends State<_ProfileGridView> {
  List<String>posts=[
    'https://bit.ly/43IEnby',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1365&q=80',
    'https://bit.ly/43IEnby',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1365&q=80',
    'https://bit.ly/43IEnby',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1365&q=80',
    'https://bit.ly/43IEnby',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1365&q=80',
    'https://bit.ly/43IEnby',
    'https://bit.ly/43IEnby'
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

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

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
        children: const [
          _ProfileInfo(),
          SizedBox(height: 12.0),
          _ProfileBio(),
          SizedBox(height: 12.0),
          _ProfileButtons(),
          _StoryHighlights(),
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
  List<profile_highlight> tiles=[
    profile_highlight(desc: "My pics", image: 'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1365&q=80'),
    profile_highlight(desc: "Hehe", image: 'https://bit.ly/43IEnby'),
    profile_highlight(desc: "Bye", image: 'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1365&q=80'),
    profile_highlight(desc: "My pics1", image: 'https://bit.ly/43IEnby'),
    profile_highlight(desc: "Hehe1", image: 'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1365&q=80'),
    profile_highlight(desc: "Bye1", image: 'https://bit.ly/43IEnby'),

  ];
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

class _ProfileButtons extends StatefulWidget {
  const _ProfileButtons({super.key});

  @override
  State<_ProfileButtons> createState() => _ProfileButtonsState();
}

class _ProfileButtonsState extends State<_ProfileButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            SizedBox(
              width: 164.0,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey,
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
                  backgroundColor: Colors.grey,
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
    );
  }
}

class _ProfileBio extends StatefulWidget {
  const _ProfileBio({super.key});

  @override
  State<_ProfileBio> createState() => _ProfileBioState();
}

class _ProfileBioState extends State<_ProfileBio> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("PARAS UPADHAYAY",
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ],
    );
  }
}

class _ProfileInfo extends StatefulWidget {
  const _ProfileInfo({super.key});

  @override
  State<_ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<_ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _ProfileImage(),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _ProfileFollowersCountWidget(
                count: "11",
                title: "Posts",
              ),
              _ProfileFollowersCountWidget(
                count: "4,710",
                title: "Followers",
              ),
              _ProfileFollowersCountWidget(
                count: "150",
                title: "Following",
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileFollowersCountWidget extends StatefulWidget {
  const _ProfileFollowersCountWidget({
    Key? key,
    required this.title,
    required this.count,
  }) : super(key: key);

  final String title, count;

  @override
  State<_ProfileFollowersCountWidget> createState() => _ProfileFollowersCountWidgetState();
}

class _ProfileFollowersCountWidgetState extends State<_ProfileFollowersCountWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.count,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white
          ),
        ),
        Text(widget.title,
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ],
    );
  }
}

class _ProfileImage extends StatefulWidget {
  const _ProfileImage({
    Key? key,
  }) : super(key: key);

  @override
  State<_ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<_ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage('https://bit.ly/43IEnby'),
            ),
          ),
        ),
      ],
    );
  }
}

class _InstagramProfileAppBar extends StatefulWidget {
  const _InstagramProfileAppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<_InstagramProfileAppBar> createState() => _InstagramProfileAppBarState();
}

class _InstagramProfileAppBarState extends State<_InstagramProfileAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.black,
      automaticallyImplyLeading: false,
      pinned: true,
      title: Row(
        children: const [
          Text(
            "43.paras.57",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add_box_outlined),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.dehaze_outlined),
        ),
      ],
    );
  }
}




