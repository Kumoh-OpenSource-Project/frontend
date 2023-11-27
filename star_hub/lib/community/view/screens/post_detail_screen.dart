import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:star_hub/common/const.dart';
import 'package:star_hub/common/styles/fonts/font_style.dart';
import 'package:star_hub/common/styles/sizes/sizes.dart';
import 'package:star_hub/community/model/entity/delete_article_entity.dart';
import 'package:star_hub/community/model/entity/detail_post_entity.dart';
import 'package:star_hub/community/model/entity/place_post_entity.dart';
import 'package:star_hub/community/model/service/post_service.dart';
import 'package:star_hub/community/view/widgets/comment_box.dart';
import 'package:star_hub/community/view/widgets/icon_num.dart';
import 'package:star_hub/community/view_model/detail_post_viewmodel.dart';

import '../../model/entity/comment_entity.dart';
import '../../model/repository/community_repository.dart';
import 'edit_screen.dart';

class DetailPage extends ConsumerStatefulWidget {
  const DetailPage(this.type, {Key? key}) : super(key: key);
  final int type;

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  late TextEditingController _commentController;
  int activeIndex = 0;
  String newComment = '';

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
  }

  void _onMoreVertTap(DetailPostEntity entity,
      DetailPostViewModel viewModel, int type) {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(1000.0, 0.0, 0.0, 0.0),
      color: Colors.black,
      items: [
        if (true)
          const PopupMenuItem(
            value: 'edit',
            child: Text('수정하기'),
          ),
        if (true)
          const PopupMenuItem(
            value: 'delete',
            child: Text('삭제하기'),
          ),
        if (false)
          const PopupMenuItem(
            value: 'report',
            child: Text('신고하기'),
          ),
      ],
    ).then((value) async {
      if (value == 'edit') {
        String? result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                EditPage(post: entity, viewModel: viewModel, type: type,),
          ),
        );
        if (result != null) {
          setState(() {
            entity.content = result;
          });
        }
      } else if (value == 'delete') {
        print("t삭제");
        _showDeleteConfirmationDialog(entity, viewModel, type);
      }
    });
  }

  void _showDeleteConfirmationDialog(
      DetailPostEntity entity, DetailPostViewModel viewModel, int type) {
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
                print("1");

                Navigator.pop(context);
                Navigator.pop(context, true);
              },
              child: const Text(
                '취소',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                print("3");
                Navigator.pop(context);
                Navigator.pop(context, true);
                viewModel.deletePost(type, entity.id);
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

  void _submitComment(DetailPostEntity entity) {
    setState(() {
      entity.comments.add(CommentEntity(
        content: newComment,
        nickName: 'CurrentUser',
        writeDate: 'Just Now',
        level: 'User Level',
      ));
      _commentController.clear();
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(detailPostViewModelProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                    ),
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
                                viewModel.detailPostEntity.title,
                                style: kTextContentStyleMiddle,
                              ),
                              InkWell(
                                onTap: () => _onMoreVertTap(
                                    viewModel.detailPostEntity,
                                viewModel, widget.type
                                ),
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
                                ),
                              ),
                              const SizedBox(
                                width: kPaddingSmallSize,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        viewModel.detailPostEntity.nickName,
                                        style: kTextContentStyleSmall,
                                      ),
                                      const Text(" • "),
                                      Text(
                                        viewModel.detailPostEntity.writeDate,
                                        style: kTextContentStyleXSmall,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    viewModel.detailPostEntity.level,
                                    style: kTextSubContentStyleXSmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: kPaddingMiddleSize,
                          ),
                          viewModel.detailPostEntity.photos.isNotEmpty
                              ? Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: <Widget>[
                                      CarouselSlider.builder(
                                        options: CarouselOptions(
                                          initialPage: 0,
                                          viewportFraction: 1,
                                          enlargeCenterPage: true,
                                          onPageChanged: (index, reason) =>
                                              setState(() {
                                            activeIndex = index;
                                          }),
                                        ),
                                        itemCount: viewModel
                                            .detailPostEntity.photos.length,
                                        itemBuilder:
                                            (context, index, realIndex) {
                                          final path = viewModel
                                              .detailPostEntity.photos[index];
                                          return imageSlider(path, index);
                                        },
                                      ),
                                      Align(
                                          alignment: Alignment.bottomCenter,
                                          child: indicator(
                                              viewModel.detailPostEntity))
                                    ])
                              : Container(),
                          Text(
                            viewModel.detailPostEntity.content,
                            style: kTextContentStyleSmall,
                          ),
                          const SizedBox(
                            height: kPaddingMiddleSize,
                          ),
                          Row(
                            children: [
                              IconWithNumber(
                                icon: FontAwesomeIcons.heart,
                                number: viewModel.detailPostEntity.likes,
                              ),
                              IconWithNumber(
                                icon: Icons.bookmark_border,
                                number: viewModel.detailPostEntity.clips,
                              ),
                              IconWithNumber(
                                icon: Icons.messenger_outline,
                                number:
                                    viewModel.detailPostEntity.comments.length,
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
                      children: viewModel.detailPostEntity.comments
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
          ),
          Container(
            color: Colors.white,
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _commentController,
                    onChanged: (value) {
                      setState(() {
                        newComment = value;
                      });
                    },
                    style:
                        kTextContentStyleMiddle.copyWith(color: Colors.black),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: '댓글을 입력하세요...',
                      hintStyle: kTextContentStyleMiddle.copyWith(
                        color: Colors.grey,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => newComment.isNotEmpty
                      ? _submitComment(viewModel.detailPostEntity)
                      : null,
                  icon: const Icon(Icons.send, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget imageSlider(path, index) => Container(
        width: double.infinity,
        height: 240,
        color: Colors.grey,
        child: Image.network(path, fit: BoxFit.cover),
      );

  Widget indicator(DetailPostEntity entity) => Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        alignment: Alignment.bottomCenter,
        child: AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: entity.photos.length,
          effect: JumpingDotEffect(
            dotHeight: 6,
            dotWidth: 6,
            activeDotColor: Colors.white,
            dotColor: Colors.white.withOpacity(0.6),
          ),
        ),
      );
}
