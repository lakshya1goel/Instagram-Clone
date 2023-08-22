import 'package:flutter/material.dart';
import 'package:insta_clone/Services/Chats/message.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: buildAppBar(),
      body: const Body(),
    );
  }
}

AppBar buildAppBar() {
  String name="Lakshya Goel";
  Duration last_seen= Duration(minutes: 45);
  return AppBar(
    backgroundColor: Colors.black,
    title: Row(
      children: [
        const CircleAvatar(
          radius: 15.0,
          backgroundImage: NetworkImage("https://img.freepik.com/premium-photo/anime-woman-portrait-manga-style-cartoon-illustration_691560-3925.jpg"),
        ),
        const SizedBox(width: 15.0,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(color: Colors.white,
                  fontSize: 16
              ),
            ),
            Text(
              "Active ${last_seen.inMinutes}m ago",
              style: TextStyle(color: Colors.grey,
                  fontSize: 12
              ),
            )
          ],
        )
      ],
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.phone),
        onPressed: () {},
      ),
      IconButton(
        icon: const Icon(Icons.video_camera_back_outlined),
        onPressed: () {},
      ),
    ],
  );
}


class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView.builder(
              itemCount: ChatMessages.length,
              itemBuilder: (context, index) => 
                   Message(message: ChatMessages[index]),
            ),
          ),
        ),
        const ChatInputField(),
      ],
    );
  }
}


class ChatInputField extends StatefulWidget {
  const ChatInputField({super.key});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  String typeed_msg="";
  bool isTyped=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 60.0,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(38),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 38.0,
                      width: 38.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.indigo[500],
                      ),
                      child: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.camera_alt,
                        color: Colors.white,)
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    Expanded(
                      child: TextField(
                        onChanged: (value){
                          typeed_msg=value;
                          if(value.isNotEmpty){
                            isTyped=true;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Message...",
                          hintStyle: TextStyle(
                            color: Colors.grey
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                          IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.mic_none_outlined,
                            color: Colors.white,),
                          ),
                          IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.photo_outlined,
                            color: Colors.white,),
                          ),
                          IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.sticky_note_2_outlined,
                            color: Colors.white,)
                          ),],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class Message extends StatefulWidget {
  const Message({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    Widget messageContaint(ChatMessage message) {
      switch (message.messageType) {
        case ChatMessageType.text:
          return TextMessage(message: message);
        case ChatMessageType.audio:
          return AudioMessage(message: message);
        case ChatMessageType.video:
          return const VideoMessage();
        default:
          return const SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 3.0),
      child: Row(
        mainAxisAlignment:
        widget.message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!widget.message.isSender) ...[
            const CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage("https://img.freepik.com/premium-photo/anime-woman-portrait-manga-style-cartoon-illustration_691560-3925.jpg"),
            ),
            const SizedBox(width: 10.0),
          ],
          messageContaint(widget.message),
        ],
      ),
    );
  }
}


class TextMessage extends StatefulWidget {
  const TextMessage({
    Key? key,
    this.message,
  }) : super(key: key);

  final ChatMessage? message;

  @override
  State<TextMessage> createState() => _TextMessageState();
}

class _TextMessageState extends State<TextMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: (widget.message!.isSender ? Colors.indigo : Colors.grey[800]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        //(widget.message!.text.length>20 ? '${widget.message!.text.substring(0,20)}\n${widget.message!.text.substring(20)}' : widget.message!.text ),
        widget.message!.text,
        style: TextStyle(
          color: Colors.white,
              fontSize: 17.0,
        ),
      ),
    );
  }
}


class AudioMessage extends StatefulWidget {
  final ChatMessage? message;

  const AudioMessage({Key? key, this.message}) : super(key: key);

  @override
  State<AudioMessage> createState() => _AudioMessageState();
}

class _AudioMessageState extends State<AudioMessage> {
  Duration time=Duration(seconds: 37);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: (widget.message!.isSender ? Colors.indigo: Colors.grey[800]),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.play_arrow,
            color: Colors.white,),
          ),
          Expanded(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 10.0),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          Text(
            '${time.inMinutes}:${(time.inSeconds % 60)}',
            style: TextStyle(
              color: Colors.white,
                fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}


class VideoMessage extends StatefulWidget {
  const VideoMessage({Key? key}) : super(key: key);

  @override
  State<VideoMessage> createState() => _VideoMessageState();
}

class _VideoMessageState extends State<VideoMessage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 250.0,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Set the background color to black
              ),
            onPressed: (){},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                  child: Image.network("https://image.winudf.com/v2/image1/Y29tLkhEU2NlbmVyeXdhbGxwYXBlci5zY2VuZXJ5aW1hZ2UubmF0dXJld2FsbHBhcGVyLmhkd2FsbHBhcGVyX3NjcmVlbl8wXzE1OTUzMjQzMDJfMDYx/screen-0.webp?fakeurl=1&type=.webp")),
          ),
        ],
      ),
    );
  }
}