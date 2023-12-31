import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
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
  final int categoryId;

  const PostBox(
      {super.key,
      required this.title,
      required this.content,
      required this.nickName,
      required this.writeDate,
      required this.likes,
      required this.clips,
      required this.onTap,
      required this.categoryId});

  static const List<String> category = [
    " ",
    "관측도구 게시판",
    "관측장소 게시판",
    "사진자랑 게시판"
  ];

  String formatTimeDifference(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    DateTime now = DateTime.now();
    String formattedNow = DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'").format(now);
    DateTime nowDate = DateTime.parse(formattedNow);
    Duration difference = nowDate.difference(date);

    if (difference.inDays > 365) {
      return DateFormat('YYYY-MM-dd').format(date);
    } else if (difference.inDays > 0) {
      return DateFormat('MM-dd').format(date);
    } else if (difference.inHours > 0) {
      return DateFormat('HH:mm').format(date);
    } else if (difference.inMinutes > 0) {
      return DateFormat('HH:mm').format(date);
    } else {
      return DateFormat('HH:mm').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final post = Post(
      title: title,
      content: content,
      nickName: nickName,
      writeDate: formatTimeDifference(writeDate),
      likes: likes,
      clips: clips,
      categoryId: categoryId,
    );
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white24,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.only(top:14, bottom: 14, left: 18, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Text(
                      category[post.categoryId],
                      style: kTextContentStyleSmall2.copyWith(
                          color: Colors.blueGrey),
                    ),
                  ),
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
                      if (post.clips != null)
                        const Text("|  "),
                      Row(
                        children: [
                          Text("${post.nickName}",
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
  final int categoryId;

  const Post(
      {required this.title,
      required this.content,
      required this.nickName,
      required this.writeDate,
      required this.likes,
      required this.clips,
      required this.categoryId});
}
