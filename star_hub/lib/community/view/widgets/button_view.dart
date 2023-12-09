import 'package:flutter/material.dart';

class ButtonView extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;
  final String heroTag;

  ButtonView(
      {super.key,
      required this.onTap,
      required this.child,
      required this.heroTag});

  @override
  State<ButtonView> createState() => _ButtonViewState();
}

class _ButtonViewState extends State<ButtonView>
    with SingleTickerProviderStateMixin {
  final Duration time = const Duration(microseconds: 100);

  late AnimationController _buttonController = AnimationController(
    vsync: this,
    duration: time,
    lowerBound: 0.0,
    upperBound: 0.4,
  )..addListener(() => setState(() {}));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _buttonController.forward();
        print('forward!!');
        Future.delayed(time, () {
          _buttonController.reverse();
        });
        print('backward!!');
        widget.onTap();
      },
      child: Transform.scale(
        scale: 1 + _buttonController.value,
        child: widget.child,
      ),
    );
  }
}
