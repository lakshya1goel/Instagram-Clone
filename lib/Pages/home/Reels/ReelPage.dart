import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:card_swiper/card_swiper.dart';
import '../../../Services/Story/reel.dart';
import 'Reel.dart';

class Reels extends StatefulWidget {
  Reels({super.key});

  List<ReelObject> reels = [
    ReelObject(
        ReelURL: 'https://www.exit109.com/~dnn/clips/RW20seconds_1.mp4',
        UserName: 'Pappu4357',
        UserProfilePic: 'https://bit.ly/3qdxC3s',
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
        UserProfilePic: 'https://bit.ly/3qdxC3s',
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

  bool _isFavorited = false;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Swiper(
              scrollDirection: Axis.vertical,
              itemCount: widget.reels.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    GestureDetector(
                      onDoubleTap: () {
                        if(widget.reels[index].Liked == false){
                          widget.reels[index].Likes++;
                        }
                        setState(() {
                          widget.reels[index].Liked = true;
                          _isFavorited = true;
                        });
                        Future.delayed(Duration(milliseconds: 500), () {
                          setState(() {
                            _isFavorited = false;
                          });
                        });
                      },
                      child: Center(
                        child: ReelView(Reel: widget.reels[index]),
                      ),
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
                      Center(
                        child: AnimatedOpacity(
                          opacity: _isFavorited ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 300),
                          child: Icon(
                            Icons.favorite,
                            size: 100,
                            color: Colors.white,
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
                      left: MediaQuery.of(context).size.width*0.83,
                      top: MediaQuery.of(context).size.height*0.05,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color:Colors.white,
                        size: 30,
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width*0.83,
                      top: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).size.height / 2.25,
                      child: Column(
                        children: [
                          widget.reels[index].Liked
                              ? InkWell(
                                  onTap: () {
                                    widget.reels[index].Likes--;
                                    setState(() {
                                      widget.reels[index].Liked =
                                          !widget.reels[index].Liked;
                                    });
                                  },
                                  child: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Column(
                                      children: [
                                        Image(
                                          height: 27,
                                          width: 27,
                                          image:
                                              AssetImage('assets/Icons/Loved.png'),
                                        ),
                                        SizedBox(height: 5,),
                                        Text(
                                          '${widget.reels[index].Likes}',
                                          style: TextStyle(
                                              color: Colors.white
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    widget.reels[index].Likes++;
                                    setState(() {
                                      widget.reels[index].Liked =
                                          !widget.reels[index].Liked;
                                    });
                                  },
                                  child:  SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: Column(
                                      children: [
                                        Image(
                                          height: 27,
                                          width: 27,
                                          image:
                                          AssetImage('assets/Icons/love.png'),
                                        ),
                                        SizedBox(height: 5,),
                                        Text(
                                          '${widget.reels[index].Likes}',
                                          style: TextStyle(
                                              color: Colors.white
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                          InkWell(
                            child: SizedBox(
                              height: 60,
                              width: 60,
                              child: Column(
                                children: [
                                  Image(
                                    height: 37,
                                    width: 37,
                                    image: AssetImage('assets/Icons/chat.png'),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    '${widget.reels[index].Comments}',
                                    style: TextStyle(
                                      color: Colors.white
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          InkWell(
                            child: SizedBox(
                              height: 60,
                              width: 60,
                              child: Column(
                                children: [
                                  Image(
                                    height: 26,
                                    width: 26,
                                    image: AssetImage('assets/Icons/send.png'),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    '${widget.reels[index].Shares}',
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
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
      ],
    );
  }
}
