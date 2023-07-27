import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 25.0,
          ),
          buildSearchBar(),
          Expanded(
            child: _SearchGridView()
          ),
        ],
      ),

    );
  }
}

class buildSearchBar extends StatefulWidget {
  const buildSearchBar({super.key});

  @override
  State<buildSearchBar> createState() => _buildSearchBarState();
}

class _buildSearchBarState extends State<buildSearchBar> {
  String searched="";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.grey[850],
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextFormField(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchMode()),
              );
            },
            style: TextStyle(color: Colors.white), // Text color
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.white),
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              searched=value;
            },
          ),
        ),
      ),
    );
  }
}


class _SearchGridView extends StatefulWidget {
  const _SearchGridView({super.key});

  @override
  State<_SearchGridView> createState() => _SearchGridViewState();
}

class _SearchGridViewState extends State<_SearchGridView> {
  List<String>posts=[
    'https://bit.ly/43IEnby',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1365&q=80',
    'https://bit.ly/43IEnby',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1365&q=80',
    'https://bit.ly/43IEnby',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1365&q=80',
    'https://bit.ly/43IEnby',
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1365&q=80',
    'https://bit.ly/43IEnby',
    'https://bit.ly/43IEnby'
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        final post = posts[index];
        return Container(
          color: Colors.grey,
          child: Image.network(
            post,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}

class SearchMode extends StatefulWidget {
  const SearchMode({super.key});

  @override
  State<SearchMode> createState() => _SearchModeState();
}

class _SearchModeState extends State<SearchMode> {
  String searched="";
  final _searchFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    // Open the keyboard automatically when the page is navigated to
    _requestSearchFieldFocus();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _requestSearchFieldFocus() {
    // Delaying the focus request to ensure the keyboard is shown properly
    Future.delayed(Duration(milliseconds: 100), () {
      FocusScope.of(context).requestFocus(_searchFocusNode);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
        SizedBox(
        height: 25.0,
       ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          color: Colors.grey[850],
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              focusNode: _searchFocusNode,
              style: TextStyle(color: Colors.white), // Text color
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.white),
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                searched=value;
              },
            ),
          ),
        ),
      ),
       ],
      ),
    );
  }
}





