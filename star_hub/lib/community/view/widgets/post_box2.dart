import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:star_hub/common/styles/sizes/sizes.dart';
import 'package:star_hub/community/view/widgets/icon_num.dart';

import '../../../common/styles/fonts/fonts.dart';

class PostBox2 extends StatelessWidget {
  final String title;
  final String content;
  final String nickName;
  final String writeDate;
  final String level;
  final int likes;
  final int clips;
  final int comments;

  const PostBox2(
      {super.key,
      required this.title,
      required this.content,
      required this.nickName,
      required this.writeDate,
      required this.level,
      required this.likes,
      required this.clips,
      required this.comments});

  @override
  Widget build(BuildContext context) {
    final post = Post(
        title: title,
        content: content,
        nickName: nickName,
        writeDate: writeDate,
        level: level,
        likes: likes,
        clips: clips,
        comments: comments);
    return Container(
        // margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        // padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        // decoration: BoxDecoration(
        //   border: Border.all(color: Colors.white, width: 2.0),
        //   borderRadius: BorderRadius.circular(20.0),
        // ),
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: Colors.white, thickness: 1),
        Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    post.title,
                    style: kTextContentStyleMiddle,
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.more_vert,
                  ),
                ],
              ),
              const SizedBox(
                height: kPaddingSmallSize,
              ),
              Container(
                // decoration: BoxDecoration(
                //     border: Border.all(color: Colors.white, width: 2.0),),
                padding: const EdgeInsets.symmetric(horizontal:0),
                child: Text(
                  post.content,
                  overflow: TextOverflow.ellipsis, // 여기서 설정
                  maxLines: 2,
                  style: kTextContentStyleXSmall,
                ),
              ),
              const SizedBox(
                height: kPaddingSmallSize,
              ),
              Row(
                children: [
                  const IconWithNumber(
                    icon: FontAwesomeIcons.heart,
                    number: 5,
                  ),
                  const IconWithNumber(
                    icon: Icons.bookmark_border,
                    number: 5,
                  ),
                  const IconWithNumber(
                    icon: Icons.messenger_outline,
                    number: 5,
                  ),
                  Row(
                    children: [
                      Text("|  ${post.nickName}", style: kTextContentStyleXSmall),
                      const Text("  |  ", style: kTextContentStyleXSmall,),
                      Text(
                        post.writeDate,
                        style: kTextContentStyleXSmall,
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ));
  }
}

class Post {
  final String title;
  final String content;
  final String nickName;
  final String writeDate;
  final String level;
  final int likes;
  final int clips;
  final int comments;

  const Post(
      {required this.title,
      required this.content,
      required this.nickName,
      required this.writeDate,
      required this.level,
      required this.likes,
      required this.clips,
      required this.comments});
}
