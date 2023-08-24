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
    this.heightFiles = 200,
    this.heightAssets = 200,
    required this.user
  });

  @override
  State<CropResultView> createState() => _CropResultViewState();
}

class _CropResultViewState extends State<CropResultView> {
  double height = 150;
  TextEditingController descriptionController = TextEditingController();
  Widget _buildCroppedImagesListView(BuildContext context) {
    print(widget.croppedFiles);
    print("lo kar lo baat!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    int length =widget.croppedFiles.length;
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      scrollDirection: Axis.horizontal,
      itemCount: length,
      itemBuilder: (BuildContext _, int index) {
        return Stack(
          children: [
            Padding(
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
            ),
            Positioned(
              left: 150,
              top: 15,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black
                ),
                child: IconButton(
                  icon: Icon(Icons.close,color: Colors.white,size: 15,),
                  onPressed: (){
                    setState(() {
                      widget.croppedFiles.removeAt(index);
                      length-=1;
                      if(length ==0){
                        Navigator.pop(context);
                      }
                    });

                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            height: widget.croppedFiles.isNotEmpty ? widget.heightFiles : 40.0,
            child: _buildCroppedImagesListView(context),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade800,
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                style: TextStyle(color: Colors.white), // Text color
                decoration: InputDecoration(
                  hintText: "Enter Post Description",
                  hintStyle: TextStyle(color: Colors.grey.shade400), // Hint text color
                  border: InputBorder.none, // Remove default border
                ),
                controller: descriptionController,
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              UploadPost(user: widget.user,description: descriptionController.text, posts: widget.croppedFiles).uploadPost(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Button color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Upload Pics",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}