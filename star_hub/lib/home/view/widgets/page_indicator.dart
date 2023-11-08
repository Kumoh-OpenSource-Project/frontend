import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.controller,
    required this.pages,
  });

  final PageController controller;
  final List<Widget> pages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SmoothPageIndicator(
        controller: controller,
        count: pages.length,
        effect: const WormEffect(
          activeDotColor: Colors.black45,
          dotHeight: 8,
          dotWidth: 8,
          type: WormType.thinUnderground,
        ),
      ),
    );
  }
}
