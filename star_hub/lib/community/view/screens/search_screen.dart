import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          controller: _searchController,
          cursorColor: Colors.white,
          onChanged: (text) {
            setState(() {});
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
              icon: const Icon(Icons.clear),
              color: Colors.white,
              onPressed: () {
                _searchController.clear();
              },
            )
                : null,
            hintText: '검색어를 입력하세요.',
            hintStyle: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: const Center(
        child: Text('Search Screen Content'),
      ),
    );
  }
}
