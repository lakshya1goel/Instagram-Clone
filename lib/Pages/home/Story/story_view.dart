import 'package:flutter/material.dart';
import 'package:insta_clone/Pages/home/Story/story.dart';
import 'package:story/story_image.dart';
import 'package:story/story_page_view.dart';

import 'home_story.dart';

class StoriesPage extends StatefulWidget {
  final int selectedPage;
  final List<StoryPageModel> status;
  final List<StoryModel> stories;
  const StoriesPage({super.key, required this.selectedPage,required this.status, required this.stories});

  @override
  State<StoriesPage> createState() => _StoriesPageState();

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
          final user = widget.stories[pageIndex];
          final story = widget.stories[pageIndex].storyModelUserStories![0];
          if(storyIndex == widget.stories[pageIndex].storyModelUserStories!.length-1){
            widget.status[pageIndex+widget.selectedPage].seen = true;
          }
          return Stack(
            children: [
              Positioned.fill(
                child: Container(color: Colors.black),
              ),
              Positioned.fill(
                child: StoryImage(
                  key: ValueKey(story),
                  imageProvider: NetworkImage(
                    story.image!,
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
                          image: NetworkImage(user.storyModelProfilePic!),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      user.storyModelUserName??"",
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
        pageLength: widget.stories.length - widget.selectedPage,
        storyLength: (int pageIndex ) {
          return widget.stories[pageIndex+widget.selectedPage].storyModelUserStories!.length;
        },
        onPageLimitReached: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}