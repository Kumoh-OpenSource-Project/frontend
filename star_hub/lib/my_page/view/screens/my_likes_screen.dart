import 'package:flutter/material.dart';

class MyLikesPage extends StatelessWidget {
  const MyLikesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('내가 좋아요한 글'),
      ),
      backgroundColor: Colors.black,
      body: const Center(
        child: Text('내가 좋아요한 글'),
      ),
    );
  }
}