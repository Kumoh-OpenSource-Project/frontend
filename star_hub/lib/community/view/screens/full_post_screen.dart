import 'package:flutter/material.dart';

class FullPostPage extends StatelessWidget {
  const FullPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.edit, color: Colors.black),
      ),
    );
  }
}
