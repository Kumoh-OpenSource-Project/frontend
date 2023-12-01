import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/repository/community_repository.dart';
import '../../model/service/search_service.dart';
import '../widgets/post_box2.dart';

final searchServiceProvider = Provider<SearchService>((ref) {
  return SearchService(ref.watch(communityRepositoryProvider));
});

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Post> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          controller: _searchController,
          cursorColor: Colors.white,
          onChanged: (text) {
            setState(() {
              searchResults = _getDummyData().where((post) {
                return post.title.toLowerCase().contains(text.toLowerCase()) ||
                    post.content.toLowerCase().contains(text.toLowerCase());
              }).toList();
            });
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
              icon: const Icon(Icons.clear),
              color: Colors.white,
              onPressed: () {
                _searchController.clear();
                setState(() {
                  searchResults.clear();
                });
              },
            )
                : null,
            hintText: '검색어를 입력하세요.',
            hintStyle: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: _buildSearchResults(),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final post = searchResults[index];
        return PostBox2(
          title: post.title,
          content: post.content,
          nickName: post.nickName,
          writeDate: post.writeDate,
          level: post.level,
          likes: post.likes,
          clips: post.clips,
          comments: post.comments,
          onTap: () {},
        );
      },
    );
  }

  List<Post> _getDummyData() {
    return List.generate(
      10,
          (index) => Post(
        title: 'title $index',
        content: 'content $index',
        nickName: 'user $index',
        writeDate: '2023-11-30',
        level: '수성',
        likes: 5,
        clips: 3,
        comments: 10,
      ),
    );
  }
}