import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:insta_like_button/insta_like_button.dart';
import 'package:video_player/video_player.dart';
import '../../../Services/Story/reel.dart';

class ReelView extends StatefulWidget {
  final ReelObject Reel;
  ReelView({super.key, required this.Reel});

  @override
  State<ReelView> createState() => _ReelViewState();
}

class _ReelViewState extends State<ReelView> {

  bool muted  = false;

  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future initializePlayer() async {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.Reel.ReelURL));
    await Future.wait([_videoPlayerController.initialize()]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      showControls: false,
      looping: true,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          if(muted){
            _videoPlayerController.setVolume(0);
          }
          else{
            _videoPlayerController.setVolume(100);
          }
          muted = !muted;
        });
      },
      child: Stack(
        children: [
          _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Chewie(
                    controller: _chewieController!,

                  ))
              : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text('Loading...')
                  ],
                ),
        ],
      ),
    );
  }
}
