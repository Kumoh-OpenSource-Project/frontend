import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullImagePage extends StatefulWidget {
  final List<String> imagePaths;
  final int initialPageIndex;

  const FullImagePage({
    Key? key,
    required this.imagePaths,
    required this.initialPageIndex,
  }) : super(key: key);

  @override
  _FullImagePageState createState() => _FullImagePageState();
}

class _FullImagePageState extends State<FullImagePage> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPageIndex);
    _currentPageIndex = widget.initialPageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('${_currentPageIndex + 1}/${widget.imagePaths.length}'),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            // Swiped right
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else if (details.primaryVelocity! < 0) {
            // Swiped left
            _pageController.previousPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.imagePaths.length,
          itemBuilder: (context, index) {
            final path = widget.imagePaths[index];
            return InteractiveViewer(
              constrained: true,
              child: Center(
                child: CachedNetworkImage(
                  key: Key(path),
                  imageUrl: '${path.replaceFirst('https', 'http')}',
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          onPageChanged: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
