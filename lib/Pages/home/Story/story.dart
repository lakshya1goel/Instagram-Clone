import 'home_story.dart';

class StoryModel{
  String? storyModelUserName;
  String? storyModelProfilePic;
  List<StoryPageModel>? storyModelUserStories;
  String? uid;
  StoryModel({required this.storyModelUserName, required this.storyModelProfilePic, required this.storyModelUserStories,required this.uid});
}