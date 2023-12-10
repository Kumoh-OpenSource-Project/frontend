import 'package:flutter/material.dart';
import 'package:star_hub/common/styles/fonts/font_style.dart';
import 'package:star_hub/common/styles/sizes/sizes.dart';
import 'package:star_hub/community/view_model/detail_post_viewmodel.dart';

import '../../model/entity/report_entity.dart';
import '../../model/service/report_service.dart';

class CommentBox extends StatefulWidget {
  const CommentBox({
    super.key,
    required this.content,
    required this.nickName,
    required this.writeDate,
    required this.level,
    required this.viewModel,
    required this.articleId,
    required this.userId,
    required this.currentUserId,
    required this.commentId,
    required this.userImage,
  });

  final String content;
  final String userImage;
  final String nickName;
  final String writeDate;
  final int userId;
  final String level;
  final int articleId;
  final String currentUserId;
  final int commentId;
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
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1.0, color: Colors.white38))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (widget.userImage.startsWith('https') == true)
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(widget.userImage),
                    )
                  else
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
                              if (widget.userId.toString() ==
                                  widget.currentUserId)
                                ListTile(
                                  leading: const Icon(Icons.delete),
                                  title: const Text('삭제하기'),
                                  onTap: () {
                                    widget.viewModel.deleteComment(
                                        widget.articleId, widget.commentId);
                                    Navigator.pop(context);
                                  },
                                ),
                              if (widget.userId.toString() !=
                                  widget.currentUserId)
                                ListTile(
                                  leading: const Icon(Icons.announcement_sharp),
                                  title: const Text('신고하기'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    _showReportDialog(context);
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
                  style: kTextContentStyleSmall3,
                ),
        ],
      ),
    );
  }

  void _saveComment() {
    setState(() {
      _isEditing = false;
      _editedContent = _editingController.text;
    });
  }

  void _showReportDialog(BuildContext context) {
    String reportContent = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text('신고하기'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onChanged: (value) {
                  reportContent = value;
                },
                style: kTextContentStyleSmall.copyWith(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: '신고 내용을 입력하세요...',
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintStyle: kTextContentStyleSmall.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child:
                        const Text('취소', style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      ReportEntity reportEntity = ReportEntity(
                        type: 'comment',
                        id: widget.commentId,
                        reportContent: reportContent,
                      );

                      try {
                        await ReportService().report(reportEntity);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.black,
                            content: Text(
                              '신고가 성공적으로 제출되었습니다.',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('신고 제출 중 오류가 발생했습니다.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }

                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child:
                        const Text('신고', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
