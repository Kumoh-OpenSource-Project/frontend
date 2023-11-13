import 'package:flutter/material.dart';
import 'package:star_hub/common/styles/fonts/font_style.dart';
import 'package:star_hub/common/styles/sizes/sizes.dart';

class CommentBox extends StatelessWidget {
  const CommentBox(
      {super.key,
      required this.content,
      required this.nickName,
      required this.writeDate,
      required this.level});

  final String content;
  final String nickName;
  final String writeDate;
  final String level;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  radius: 15,
                  child: Icon(
                    Icons.person,
                    size: 25,
                  )),
              const SizedBox(
                width: kPaddingSmallSize,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nickName, style: kTextContentStyleSmall),
                  Text(
                    level,
                    style: kTextSubContentStyleXSmall,
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: kPaddingMiddleSize,
          ),
          Text(
            content,
            style: kTextContentStyleSmall,
          ),
        ],
      ),
    );
  }
}
