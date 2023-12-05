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
  final int? likes;
  final int? clips;
  final VoidCallback? onTap;

  const PostBox({
    super.key,
    required this.title,
    required this.content,
    required this.nickName,
    required this.writeDate,
    required this.likes,
    required this.clips,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final post = Post(
      title: title,
      content: content,
      nickName: nickName,
      writeDate: writeDate,
      likes: likes,
      clips: clips,
    );
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(
        color: Colors.white24,
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
                      if (post.likes != null)
                        IconWithNumber(
                          icon: FontAwesomeIcons.heart,
                          number: post.likes!,
                        ),
                      if (post.clips != null)
                        IconWithNumber(
                          icon: Icons.bookmark_border,
                          number: post.clips!,
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
  final int? likes;
  final int? clips;

  const Post({
    required this.title,
    required this.content,
    required this.nickName,
    required this.writeDate,
    required this.likes,
    required this.clips,
  });
}
