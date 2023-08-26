import 'dart:async';
import 'package:flutter/material.dart';
import 'package:insta_clone/Models/UserModel.dart';
import 'package:insta_assets_picker/insta_assets_picker.dart';
import 'package:insta_clone/Pages/home/ProfilePic/crop.dart';
import 'package:permission_handler/permission_handler.dart';

class PickerScreen extends StatefulWidget {
  final UserModel user;
  final List<AssetEntity> selectedAssets;
  final StreamController<InstaAssetsExportDetails?> fileStream;
  const PickerScreen({super.key,required this.selectedAssets,required this.fileStream,required this.user});

  @override
  State<PickerScreen> createState() => _PickerScreenState();
}

class _PickerScreenState extends State<PickerScreen> {


  PermissionStatus _permissionStatus = PermissionStatus.denied;

  Future<void> requestPermission(Permission permissionCamera,Permission permissionPhoto) async {
    final status1 = await permissionPhoto.request();
    final status2 = await permissionCamera.request();
    print("yaha aa gya kya tu");
    setState(() {
      print("$status1 and $status1");
      _permissionStatus = (status2 == PermissionStatus.granted && status1 == PermissionStatus.granted) ? PermissionStatus.granted  : PermissionStatus.denied;
      print(_permissionStatus);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: const Text('Confirm'),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<InstaAssetsExportDetails?>(
          stream: widget.fileStream.stream,
          builder: (context, snapshot) {
            return CropResultView(
              selectedAssets: widget.selectedAssets,
              croppedFiles: (snapshot.data != null) ? snapshot.data!.croppedFiles : [],
              user: widget.user,
            );
          }
      ),
    );
  }
}

