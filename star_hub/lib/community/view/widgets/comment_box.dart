import 'package:flutter/material.dart';
import 'package:star_hub/common/styles/fonts/font_style.dart';
import 'package:star_hub/common/styles/sizes/sizes.dart';
import 'package:star_hub/community/view_model/detail_post_viewmodel.dart';

class CommentBox extends StatefulWidget {
  const CommentBox({
    super.key,
    required this.content,
    required this.nickName,
    required this.writeDate,
    required this.level,
    required this.viewModel,
    required this.articleId,
  });

  final String content;
  final String nickName;
  final String writeDate;
  final String level;
  final int articleId;
  final DetailPostViewModel viewModel;

  @override
  _CommentBoxState createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  late TextEditingController _editingController;
  bool _isEditing = false;
  String _editedContent = '';

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: widget.content);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    ),
                  ),
                  const SizedBox(
                    width: kPaddingSmallSize,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.nickName, style: kTextContentStyleSmall),
                      Text(
                        widget.level,
                        style: kTextSubContentStyleXSmall,
                      ),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.black,
                    context: context,
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16.0),
                        ),
                        child: Container(
                          color: Colors.white12,
                          child: Wrap(
                            children: <Widget>[
                              if (true)
                                ListTile(
                                  leading: const Icon(Icons.delete),
                                  title: const Text('삭제하기'),
                                  onTap: () {
                                    // TODO: 코멘트 아이디 추가하기!!
                                    // widget.viewModel.deleteComment(
                                    //     widget.articleId, commentId)
                                    Navigator.pop(context);
                                  },
                                ),
                              if (false)
                                ListTile(
                                  leading: const Icon(Icons.announcement_sharp),
                                  title: const Text('신고하기'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Icon(Icons.more_vert),
              ),
            ],
          ),
          const SizedBox(
            height: kPaddingMiddleSize,
          ),
          _isEditing
              ? TextField(
            controller: _editingController,
            style: kTextContentStyleSmall,
            decoration: const InputDecoration(
              hintText: '댓글을 수정하세요...',
            ),
            onEditingComplete: () {
              _saveComment();
            },
          )
              : Text(
            _editedContent.isNotEmpty ? _editedContent : widget.content,
            style: kTextContentStyleSmall,
          ),
        ],
      ),
    );
  }

  void _editComment() {
    setState(() {
      _isEditing = true;
      _editedContent = widget.content;
    });
  }

  void _saveComment() {
    setState(() {
      _isEditing = false;
      _editedContent = _editingController.text;
    });
  }
}
