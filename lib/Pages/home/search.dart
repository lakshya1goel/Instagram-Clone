import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Models/UserModel.dart';
import 'package:insta_clone/Pages/home/profile.dart';

class Search extends StatefulWidget {
  final UserModel user;
  final User firebaseUser;
  const Search({Key? key, required this.user, required this.firebaseUser}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchedTextController = TextEditingController();
  String searched = "";

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.grey,
      title: TextFormField(
        onChanged: (value) {
          setState(() {
            searched = value;
          });
        },
        controller: _searchedTextController,
        decoration: InputDecoration(
          focusColor: Colors.grey,
          filled: true,
          hintText: 'Search for the user...',
          hintStyle: TextStyle(
            color: Colors.white54,
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 25,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.close,
              size: 25,
            ),
            onPressed: () {
              setState(() {
                searched = "";
                _searchedTextController.text = "";
              });
            },
          ),
        ),
      ),
    );
  }

  buildBody() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting)
            ? Center(child: CircularProgressIndicator()) // Center the loading indicator
            : ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var data =
            snapshot.data!.docs[index].data() as Map<String, dynamic>;
            if (snapshot.data!.docs.isNotEmpty &&
                searched.isNotEmpty &&
                (data['name'].toString().contains(searched) ||
                    data['username'].toString().startsWith(searched))) {
              return Card(
                elevation: 2,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Profile(userModel: widget.user, firebaseUser: widget.firebaseUser,),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(data['profilePic']),
                  ),
                  title: Text(
                    '${data['name']}',
                    style: TextStyle(color: Colors.black), // Update text color
                  ),
                  subtitle: Text(
                    '${data['username']}',
                    style: TextStyle(color: Colors.black), // Update text color
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: buildAppBar(),
        body: buildBody(),
      ),
    );
  }
}

