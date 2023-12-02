import 'package:flutter/material.dart';

class MyPostsPage extends StatelessWidget {
  const MyPostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('내가 쓴 글'),
      ),
      backgroundColor: Colors.black,
      body: const Center(
        child: Text('내가 쓴 글'),
      ),
    );
  }
}