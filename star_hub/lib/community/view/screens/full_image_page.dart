import 'package:flutter/material.dart';

class FullImagePage extends StatelessWidget {
  final String imagePath;

  const FullImagePage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.only(right: 8.0),
        //     child: Icon(Icons.more_vert),
        //   ),
        // ],
      ),
      body: Center(
        child: InteractiveViewer(
          constrained: true,

          child: Image.network(imagePath),
        ),
      ),
    );
  }
}
