import 'dart:io';
import 'package:flutter/material.dart';
import 'package:insta_assets_picker/insta_assets_picker.dart';
import 'package:insta_clone/Models/UserModel.dart';
import 'package:insta_clone/Pages/home/UploadPosts/upload_to_firebase_and_retrive.dart';

class CropResultView extends StatefulWidget {
  final UserModel user;
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
    required this.user
  });

  @override
  State<CropResultView> createState() => _CropResultViewState();
}

class _CropResultViewState extends State<CropResultView> {
  TextEditingController descriptionController = TextEditingController();
  Widget _buildCroppedImagesListView(BuildContext context) {
    print(widget.croppedFiles);
    print("lo kar lo baat!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      scrollDirection: Axis.horizontal,
      itemCount: widget.croppedFiles.length,
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
            child: Image.file(widget.croppedFiles[index]),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          height: widget.croppedFiles.isNotEmpty ? widget.heightFiles : 40.0,
          child: _buildCroppedImagesListView(context),
        ),
        const Text('Enter Description',style: TextStyle(color: Colors.white),),
        const SizedBox(height: 20),
        Container(
          width: MediaQuery.of(context).size.width*0.8,
          color: Colors.grey,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: TextField(
            controller: descriptionController,
          ),
        ),
        ElevatedButton(onPressed: (){
          UploadPost(posts: widget.croppedFiles,user: widget.user,description: descriptionController.text).uploadPost(context);
        },
            child: const Text("Upload Pics"))
      ],
    );
  }
}