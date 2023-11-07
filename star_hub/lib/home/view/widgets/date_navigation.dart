import 'package:flutter/material.dart';

class DateNavigation extends StatelessWidget {
  const DateNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 20),
          const Column(
            children: [
              Text(
                'Wednesday',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '10월 18일',
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward_ios_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
