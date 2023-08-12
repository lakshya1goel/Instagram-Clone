import 'package:flutter/material.dart';
import 'package:insta_clone/Pages/home/homepage.dart';
import 'package:insta_clone/Pages/home/profile.dart';
import 'package:insta_clone/Pages/home/Reels/ReelPage.dart';
import 'package:insta_clone/Pages/home/search.dart';
import 'package:insta_assets_picker/insta_assets_picker.dart';
import 'package:insta_clone/Services/database.dart';

import '../../Models/user_model1.dart';

class Wrapper extends StatefulWidget {
  String uid;
  Wrapper({super.key,required this.uid});

  List<Widget> Widgets = [HomePage(),Search(),Placeholder(),Reels(),Profile()];

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) async {
    if(index == 2){
       await callRestorablePicker();
       print(selectedAssets);
       _selectedIndex = 0;
       return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }
  final _instaAssetsPicker = InstaAssetPicker();
  final _provider = DefaultAssetPickerProvider(maxAssets: 10);
  late final ThemeData _pickerTheme =
  InstaAssetPicker.themeData(Theme.of(context).primaryColor).copyWith(
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 18)),
  );

  List<AssetEntity> selectedAssets = <AssetEntity>[];
  InstaAssetsExportDetails? exportDetails;

  @override
  void dispose() {
    _provider.dispose();
    _instaAssetsPicker.dispose();
    super.dispose();
  }
  Future<void> callRestorablePicker() async {
    final List<AssetEntity>? result =
    await _instaAssetsPicker.restorableAssetsPicker(
      context,
      title: 'Upload',
      closeOnComplete: true,
      provider: _provider,
      pickerTheme: _pickerTheme,
      onCompleted: (cropStream) {
        cropStream.listen((event) {
          if (mounted) {
            setState(() {
              exportDetails = event;
            });
          }
        });
      },
    );

    if (result != null) {
      selectedAssets = result;
      if (mounted) {
        setState(() {});
      }
    }
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
            items: const [
               BottomNavigationBarItem(
                label: '',
                activeIcon: SizedBox(
                  height: 20,
                  width: 20,
                  child:  Image(
                    image: AssetImage('assets/Icons/home_selected.png'),
                  ),
                ),
                icon: SizedBox(
                  height: 20,
                  width: 20,
                  child:  Image(
                    image: AssetImage('assets/Icons/home.png'),
                  ),
                ),
              ),
               BottomNavigationBarItem(
                label: '',
                icon: SizedBox(
                  height: 20,
                  width: 20,
                  child: Image(
                    image: AssetImage('assets/Icons/search.png'),
                  ),
                ),
              ),
               BottomNavigationBarItem(
                label: '',
                icon: SizedBox(
                  height: 20,
                  width: 20,
                  child:  Image(
                    image: AssetImage('assets/Icons/upload.png'),
                  ),
                ),
              ),
               BottomNavigationBarItem(
                label: '',
                activeIcon: SizedBox(
                  height: 20,
                  width: 20,
                  child: Image(
                    image: AssetImage('assets/Icons/Reels_selected.png'),
                  ),
                ),
                icon: SizedBox(
                  height: 20,
                  width: 20,
                  child: Image(
                    image: AssetImage('assets/Icons/Reels.png'),
                  ),
                ),
              ),
               BottomNavigationBarItem(
                label: '.',
                icon: CircleAvatar(
                  backgroundImage: NetworkImage('https://bit.ly/3qdxC3s'),
                  radius: 15,
                )
              ),
            ],
            selectedLabelStyle: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.red
            ),
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            print('---------------------------------------------------------');
            print('---------------------------------------------------------');
            print(widget.uid);
            print('--------------------------------------------------------');
            print('--------------------------------------------------------');
            UserModelPrimary user = await Database(uid: widget.uid).getUserData();
            print(user.userName);
            print('--------------------------------------------------------');
            print('--------------------------------------------------------');


          },
        ),
        ),
    );
  }
}