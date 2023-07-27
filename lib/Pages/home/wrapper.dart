import 'package:flutter/material.dart';
import 'package:insta_clone/Pages/home/homepage.dart';
import 'package:insta_clone/Pages/home/profile.dart';
import 'package:insta_clone/Pages/home/reels.dart';
import 'package:insta_clone/Pages/home/search.dart';
import 'package:insta_assets_picker/insta_assets_picker.dart';

class Wrapper extends StatefulWidget {
  Wrapper({super.key});

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