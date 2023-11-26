import 'package:flutter/material.dart';

class IconWithNumber extends StatelessWidget {
  final IconData icon;
  final int number;

  const IconWithNumber({
    super.key,
    required this.icon,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 15,
        ),
        const SizedBox(width: 5),
        Text(
          number.toString(),
          style: const TextStyle(fontSize: 15),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
