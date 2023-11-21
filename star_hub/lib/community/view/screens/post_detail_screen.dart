import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:star_hub/common/styles/fonts/font_style.dart';
import 'package:star_hub/common/styles/sizes/sizes.dart';
import 'package:star_hub/community/model/entity/place_post_entity.dart';
import 'package:star_hub/community/view/widgets/comment_box.dart';
import 'package:star_hub/community/view/widgets/icon_num.dart';

import 'edit_screen.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.post}) : super(key: key);
  final PlacePostEntity post;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  void _onMoreVertTap() {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(1000.0, 0.0, 0.0, 0.0),
      color: Colors.black,
      items: [
        const PopupMenuItem(
          value: 'edit',
          child: Text('수정하기'),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Text('삭제하기'),
        ),
      ],
    ).then((value) async {
      if (value == 'edit') {
        String? result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditPage(post: widget.post),
          ),
        );
        if (result != null) {
          setState(() {
            widget.post.content = result;
          });
        }
      } else if (value == 'delete') {
        _showDeleteConfirmationDialog();
      }
    });
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text('삭제 확인'),
          content: const Text('정말로 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                '취소',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, true);
              },
              child: const Text(
                '삭제',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  border: Border.symmetric(
                horizontal: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
              )),
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.post.title,
                          style: kTextContentStyleMiddle,
                        ),
                        InkWell(
                          onTap: _onMoreVertTap,
                          child: const Icon(
                            Icons.more_vert,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: kPaddingMiddleSize,
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
                                Text(widget.post.nickName,
                                    style: kTextContentStyleSmall),
                                const Text(" • "),
                                Text(
                                  widget.post.writeDate,
                                  style: kTextContentStyleXSmall,
                                )
                              ],
                            ),
                            Text(
                              widget.post.level,
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
                      widget.post.content,
                      style: kTextContentStyleSmall,
                    ),
                    const SizedBox(
                      height: kPaddingMiddleSize,
                    ),
                    Row(
                      children: [
                        IconWithNumber(
                          icon: FontAwesomeIcons.heart,
                          number: widget.post.likes,
                        ),
                        IconWithNumber(
                          icon: Icons.bookmark_border,
                          number: widget.post.clips,
                        ),
                        IconWithNumber(
                          icon: Icons.messenger_outline,
                          number: widget.post.comments.length,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: kPaddingSmallSize,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                children: widget.post.comments
                    .map((comment) => CommentBox(
                          content: comment.content,
                          nickName: comment.nickName,
                          writeDate: comment.writeDate,
                          level: comment.level,
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
