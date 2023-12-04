import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    super.key,
    required this.controller,
    required this.pages,
  });

  final PageController controller;
  final List<Widget> pages;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        physics: const BouncingScrollPhysics(),
        controller: controller,
        itemCount: pages.length,
        itemBuilder: (_, index) {
          return pages[index % pages.length];
        },
      ),
    );
  }
}

