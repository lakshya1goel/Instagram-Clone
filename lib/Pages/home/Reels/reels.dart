import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:card_swiper/card_swiper.dart';
import '../../../Services/Story/reel.dart';

class Reels extends StatefulWidget {
  Reels({super.key});

  List<ReelObject> reels = [
    ReelObject(
        ReelURL: 'https://www.exit109.com/~dnn/clips/RW20seconds_1.mp4',
        UserName: 'Pappu4357',
        UserProfilePic: 'https://bit.ly/43IEnby',
        ReelDescription:
            'This is my first reek Please Like and follow',
        Music: 'I wanna be yours',
        Followed: false,
        Liked: false,
        Likes: 101,
        Shares: 102,
        Comments: 20,
        AllComments: []),
    ReelObject(
        ReelURL: 'https://www.exit109.com/~dnn/clips/RW20seconds_1.mp4',
        UserName: 'Pappu4357',
        UserProfilePic: 'https://bit.ly/43IEnby',
        ReelDescription:
        'This is my first reek Please Like and follow',
        Music: 'I wanna be yours',
        Followed: false,
        Liked: false,
        Likes: 101,
        Shares: 102,
        Comments: 20,
        AllComments: [])
  ];

  @override
  State<Reels> createState() => _ReelsState();
}

class _ReelsState extends State<Reels> {
  bool mute = false;

  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  @override
  void initState() {
    super.initState();
  }

  Future initializePlayer() async {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.reels[0].ReelURL));
    await Future.wait(
        [_videoPlayerController?.initialize()] as Iterable<Future>);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      showControls: false,
      looping: false,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    if (_chewieController != null) {
      _chewieController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _videoPlayerController?.play();
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (mute) {
                  _videoPlayerController?.setVolume(10000);
                } else {
                  _videoPlayerController?.setVolume(0);
                }
                mute = !mute;
              });
            },
            child: Swiper(
                scrollDirection: Axis.vertical,
                itemCount: widget.reels.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      const Center(
                        child: Placeholder(),
                      ),
                      if(index == 0)
                      Positioned(
                        top: MediaQuery.of(context).size.height*0.05,
                        left: MediaQuery.of(context).size.width*0.05,
                        child:const Text(
                          'Reels',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height -
                            MediaQuery.of(context).size.height / 5,
                        left: MediaQuery.of(context).size.width*0.05,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                widthFactor: 2,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(widget.reels[index].UserProfilePic),
                                      radius: 17,
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                                    Text(
                                      widget.reels[index].UserName,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                        backgroundColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(width: 1, color: Colors.white),
                                          borderRadius: BorderRadius.circular(13),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          widget.reels[index].Followed = !widget.reels[index].Followed;
                                        });
                                      },
                                      child: widget.reels[index].Followed
                                          ? Text(
                                        'Following',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                          : Text(
                                        'Follow',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                widget.reels[index].ReelDescription,
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: 5,),
                              Container(
                                padding: EdgeInsets.fromLTRB(02, 0, 5, 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(0.5)
                                ),
                                
                                child: Row(
                                  children: [
                                    Icon(Icons.music_note,color: Colors.grey,),
                                    Text(widget.reels[index].Music,style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400
                                    ),)
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                        ,
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width*0.86,
                        top: MediaQuery.of(context).size.height*0.05,
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color:Colors.white,
                          size: 30,
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width*0.86,
                        top: MediaQuery.of(context).size.height -
                            MediaQuery.of(context).size.height / 2.25,
                        child: Column(
                          children: [
                            widget.reels[index].Liked
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        widget.reels[index].Liked =
                                            !widget.reels[index].Liked;
                                      });
                                    },
                                    child: const SizedBox(
                                      height: 27,
                                      width: 27,
                                      child: Image(
                                        image:
                                            AssetImage('assets/Icons/Loved.png'),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      setState(() {
                                        widget.reels[index].Liked =
                                            !widget.reels[index].Liked;
                                      });
                                    },
                                    child: const SizedBox(
                                      height: 27,
                                      width: 27,
                                      child: Image(
                                        image:
                                            AssetImage('assets/Icons/love.png'),
                                      ),
                                    ),
                                  ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            const InkWell(
                              child: SizedBox(
                                height: 37,
                                width: 37,
                                child: Image(
                                  image: AssetImage('assets/Icons/chat.png'),
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            const InkWell(
                              child: SizedBox(
                                height: 26,
                                width: 26,
                                child: Image(
                                  image: AssetImage('assets/Icons/send.png'),
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.more_vert,
                                color: Colors.white,
                                size: 27,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }),
          ),
        ),
      ],
    );
  }
}
