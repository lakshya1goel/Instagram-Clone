import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Models/UserModel.dart';
import 'package:insta_clone/Pages/home/homepage.dart';
import 'package:insta_clone/Pages/home/profile.dart';
import 'package:insta_clone/Pages/home/Reels/ReelPage.dart';
import 'package:insta_clone/Pages/home/search.dart';
import 'package:insta_assets_picker/insta_assets_picker.dart';

class Wrapper extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  Wrapper({Key? key, required this.userModel, required this.firebaseUser}) : super(key: key);



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
    List<Widget> Widgets = [HomePage(userModel: widget.userModel, firebaseUser: widget.firebaseUser,),Search(),Placeholder(),Reels(),Profile()];
    return Container(
      color: Colors.black,
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Widgets.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                label: '',
                activeIcon: Container(
                  height: 20,
                  width: 20,
                  child: const Image(
                    image: AssetImage('assets/Icons/home_selected.png'),
                  ),
                ),
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
              const BottomNavigationBarItem(
                label: '.',
                icon: CircleAvatar(
                  backgroundImage: NetworkImage('https://bit.ly/3qdxC3s'),
                  radius: 15,
                )
              ),
            ],
            selectedLabelStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.red
            ),
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
    );
  }
}