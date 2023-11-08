import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  const Description({
    super.key,
  });

  final text = '현재 구름이 적고 대기가 맑아\n천체를 관측하기 매우 좋습니다';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white70,
        ),
      ),
    );
  }
}