import 'package:flutter/material.dart';
import 'package:insta_clone/Services/story.dart';
import 'package:story/story_image.dart';
import 'package:story/story_page_view.dart';

class StoriesPage extends StatefulWidget {
  final int selected_page;
  StoriesPage({super.key, required this.selected_page});

  @override
  State<StoriesPage> createState() => _StoriesPageState();
  final List<story> stories = [
    story(UserName: '43.paras.57', ProfilePic: 'https://bit.ly/43IEnby', Stories: [
      'https://bit.ly/3rxMlGN','https://bit.ly/3rxMlGN','https://bit.ly/3rxMlGN',
    ]),
    story(UserName: '43.paras.57', ProfilePic: 'https://bit.ly/43IEnby', Stories: [
      'https://bit.ly/43IEnby','https://bit.ly/3rxMlGN','https://bit.ly/3rxMlGN','https://bit.ly/3rxMlGN',
    ]),
    story(UserName: '43.paras.57', ProfilePic: 'https://bit.ly/43IEnby', Stories: [
      'https://bit.ly/3rxMlGN','https://bit.ly/3rxMlGN','https://bit.ly/3rxMlGN',
    ]),
  ];
}


class _StoriesPageState extends State<StoriesPage> {
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;
  @override
  void initState() {
    super.initState();
    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(
        IndicatorAnimationCommand.resume);
  }

  @override
  void dispose() {
    indicatorAnimationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryPageView(
        itemBuilder: (context, pageIndex, storyIndex) {
          final user = widget.stories[pageIndex+widget.selected_page];
          final story = widget.stories[pageIndex+widget.selected_page].Stories[storyIndex];
          return Stack(
            children: [
              Positioned.fill(
                child: Container(color: Colors.black),
              ),
              Positioned.fill(
                child: StoryImage(
                  key: ValueKey(story),
                  imageProvider: NetworkImage(
                    story,
                  ),
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 44, left: 8),
                child: Row(
                  children: [
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(user.ProfilePic),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      user.UserName,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

            ],
          );
        },
        gestureItemBuilder: (context, pageIndex, storyIndex) {
          return Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      color: Colors.white,
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
          ]);
        },
        indicatorAnimationController: indicatorAnimationController,
        pageLength: widget.stories.length - widget.selected_page,
        storyLength: (int pageIndex ) {
          return widget.stories[pageIndex+widget.selected_page].Stories.length;
        },
        onPageLimitReached: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
