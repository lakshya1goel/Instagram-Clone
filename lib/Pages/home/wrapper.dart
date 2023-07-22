import 'package:flutter/material.dart';
import 'package:insta_clone/Pages/home/homepage.dart';
import 'package:insta_clone/Pages/home/profile.dart';
import 'package:insta_clone/Pages/home/reels.dart';
import 'package:insta_clone/Pages/home/search.dart';
import 'package:insta_clone/Pages/home/upload.dart';

class Wrapper extends StatefulWidget {
  Wrapper({super.key});

  List<Widget> Widgets = [HomePage(),Search(),Upload(),Reels(),Profile()];

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Scaffold(
          backgroundColor: Colors.black,
          body: widget.Widgets.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                label: '',
                icon: Container(
                  height: 20,
                  width: 20,
                  child: const Image(
                    image: AssetImage('assets/Icons/home.png'),
                  ),
                ),
              ),
              const BottomNavigationBarItem(
                label: '',
                icon: SizedBox(
                  height: 20,
                  width: 20,
                  child: Image(
                    image: AssetImage('assets/Icons/search.png'),
                  ),
                ),
              ),
              const BottomNavigationBarItem(
                label: '',
                icon: SizedBox(
                  height: 20,
                  width: 20,
                  child:  Image(
                    image: AssetImage('assets/Icons/upload.png'),
                  ),
                ),
              ),
             const  BottomNavigationBarItem(
                label: '',
                icon: SizedBox(
                  height: 20,
                  width: 20,
                  child: Image(
                    image: AssetImage('assets/Icons/Reels.png'),
                  ),
                ),
              ),
              const BottomNavigationBarItem(
                label: '',
                icon: CircleAvatar(
                  backgroundImage: NetworkImage('https://bit.ly/43IEnby'),
                  radius: 15,
                )
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
    );
  }
}