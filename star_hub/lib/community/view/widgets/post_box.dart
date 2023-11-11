import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:star_hub/common/styles/sizes/sizes.dart';
import 'package:star_hub/community/view/widgets/icon_num.dart';
import '../../../common/styles/fonts/font_style.dart';

class PostBox extends StatelessWidget {
  final String title;
  final String content;
  final String nickName;
  final String writeDate;
  final String level;
  final int likes;
  final int clips;
  final int comments;

  const PostBox(
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
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    Row(
                      children: [
                        Text(post.nickName, style: kTextContentStyleSmall),
                        const Text(" • "),
                        Text(
                          post.writeDate,
                          style: kTextContentStyleXSmall,
                        )
                      ],
                    ),
                    Text(
                      post.level,
                      style: kTextSubContentStyleXSmall,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: kPaddingSmallSize,
            ),
            Text(
              post.content,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(
              height: kPaddingSmallSize,
            ),
            const Row(
              children: [
                IconWithNumber(
                  icon: FontAwesomeIcons.heart,
                  number: 5,
                ),
                IconWithNumber(
                  icon: Icons.bookmark_border,
                  number: 5,
                ),
                IconWithNumber(
                  icon: Icons.messenger_outline,
                  number: 5,
                ),
              ],
            )
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
