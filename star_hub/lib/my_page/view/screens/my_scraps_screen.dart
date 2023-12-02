import 'package:flutter/material.dart';

class MyScrapsPage extends StatelessWidget {
  const MyScrapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('내가 스크랩한 글'),
      ),
      backgroundColor: Colors.black,
      body: const Center(
        child: Text('내가 스크랩한 글'),
      ),
    );
  }
}