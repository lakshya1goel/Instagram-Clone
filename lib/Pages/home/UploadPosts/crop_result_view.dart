import 'dart:io';
import 'package:flutter/material.dart';
import 'package:insta_assets_picker/insta_assets_picker.dart';

class CropResultView extends StatelessWidget {
  final List<AssetEntity> selectedAssets;
  final List<File> croppedFiles;
  final double heightFiles;
  final double heightAssets;
  const CropResultView({
    super.key,
    required this.selectedAssets,
    required this.croppedFiles,
    this.heightFiles = 300.0,
    this.heightAssets = 120.0,
  });


  Widget _buildCroppedImagesListView(BuildContext context) {
    print(selectedAssets);
    print("hello my friend!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print(croppedFiles);
    print("lo kar lo baat!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      scrollDirection: Axis.horizontal,
      itemCount: croppedFiles.length,
      itemBuilder: (BuildContext _, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 16.0,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Image.file(croppedFiles[index]),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<File>(
      stream: null,
      builder: (context, snapshot) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          height: croppedFiles.isNotEmpty ? heightFiles : 40.0,
          child: _buildCroppedImagesListView(context),
        );
      }
    );
  }
}