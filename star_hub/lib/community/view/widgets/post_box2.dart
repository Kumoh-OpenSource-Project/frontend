import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:star_hub/common/styles/sizes/sizes.dart';
import 'package:star_hub/community/model/entity/comment_entity.dart';
import 'package:star_hub/community/model/entity/detail_post_entity.dart';
import 'package:star_hub/community/model/entity/place_post_entity.dart';
import 'package:star_hub/community/view/screens/post_detail_screen.dart';
import 'package:star_hub/community/view/widgets/icon_num.dart';
import '../../../common/styles/fonts/font_style.dart';

class PostBox2 extends StatelessWidget {
  final String title;
  final String content;
  final String nickName;
  final int writerId;
  final String writeDate;
  final String level;
  final int likes;
  final int clips;
  final int comments;
  final VoidCallback? onTap;

  const PostBox2({
    super.key,
    required this.title,
    required this.content,
    required this.nickName,
    required this.writerId,
    required this.writeDate,
    required this.level,
    required this.likes,
    required this.clips,
    required this.comments,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final post = Post(
        title: title,
        content: content,
        nickName: nickName,
        writerId: writerId,
        writeDate: writeDate,
        level: level,
        likes: likes,
        clips: clips,
        comments: comments);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
        color: Colors.white.withOpacity(0.3),
        width: 1,
      ))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
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
                    ],
                  ),
                  const SizedBox(
                    height: kPaddingSmallSize,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Text(
                            post.content,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: kTextContentStyleXSmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: kPaddingSmallSize,
                  ),
                  Row(
                    children: [
                      IconWithNumber(
                        icon: FontAwesomeIcons.heart,
                        number: post.likes,
                      ),
                      IconWithNumber(
                        icon: Icons.bookmark_border,
                        number: post.clips,
                      ),
                      IconWithNumber(
                        icon: Icons.messenger_outline,
                        number: post.comments,
                      ),
                      Row(
                        children: [
                          Text("|  ${post.nickName}",
                              style: kTextContentStyleXSmall),
                          const Text(
                            "  |  ",
                            style: kTextContentStyleXSmall,
                          ),
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
          ),
        ],
      ),
    );
  }
}

class Post {
  final String title;
  final String content;
  final String nickName;
  final String writeDate;
  final String level;
  final int writerId;
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
      required this.comments,
      required this.writerId});
}
