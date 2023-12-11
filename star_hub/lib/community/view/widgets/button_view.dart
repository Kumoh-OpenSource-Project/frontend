import 'package:flutter/material.dart';

class AnimatedIconButton extends StatefulWidget {
  final VoidCallback onTap;
  final IconData iconData;
  final String text;

  AnimatedIconButton({
    Key? key,
    required this.onTap,
    required this.iconData,
    required this.text,
  }) : super(key: key);

  @override
  _AnimatedIconButtonState createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _buttonController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 200),
    lowerBound: 0.0,
    upperBound: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _buttonController.forward();
        Future.delayed(Duration(milliseconds: 200), () {
          _buttonController.reverse();
        });
        widget.onTap();
      },
      borderRadius: BorderRadius.circular(10.0), // 모서리를 둥글게 만들기
      child: Padding(
        padding: const EdgeInsets.all(0.0), // 패딩 추가
        child: Row(
          children: [
            ScaleTransition(
              scale: Tween<double>(begin: 1.0, end: 1.6).animate(_buttonController),
              child: Icon(
                widget.iconData,
                size: 24.0,
              ),
            ),
            const SizedBox(
              width: 7,
            ),
            Text(widget.text),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }
}
