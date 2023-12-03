import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:star_hub/common/local_storage/local_storage.dart';
import 'package:star_hub/common/styles/fonts/font_style.dart';
import 'package:star_hub/common/styles/sizes/sizes.dart';
import 'package:star_hub/community/model/entity/detail_post_entity.dart';
import 'package:star_hub/community/model/state/state.dart';
import 'package:star_hub/community/view/widgets/comment_box.dart';
import 'package:star_hub/community/view/widgets/icon_num.dart';
import 'package:star_hub/community/view_model/detail_post_viewmodel.dart';

import '../../model/entity/comment_entity.dart';
import '../../model/entity/report_entity.dart';
import '../../model/service/report_service.dart';
import 'edit_screen.dart';

class DetailPage extends ConsumerStatefulWidget {
  const DetailPage(this.type, this.writerId, {Key? key}) : super(key: key);
  final int type;
  final int writerId;

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  late TextEditingController _commentController;
  int activeIndex = 0;
  String newComment = '';
  late String userId;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
    _getUserId();
  }

  Future<void> _onMoreVertTap(
      DetailPostEntity entity, DetailPostViewModel viewModel, int type) async {
    _showModalBottomSheet(userId, entity, viewModel, type);
  }

  void _showModalBottomSheet(String? userId, DetailPostEntity entity,
      DetailPostViewModel viewModel, int type) {
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
                if (widget.writerId.toString() == userId)
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('수정하기'),
                    onTap: () {
                      Navigator.pop(context);
                      _editPost(entity, viewModel, type);
                    },
                  ),
                if (widget.writerId.toString() == userId)
                  ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('삭제하기'),
                    onTap: () {
                      Navigator.pop(context);
                      _showDeleteConfirmationDialog(entity, viewModel, type);
                    },
                  ),
                if (widget.writerId.toString() != userId)
                  ListTile(
                    leading: const Icon(Icons.announcement_sharp),
                    title: const Text('신고하기'),
                    onTap: () {
                      Navigator.pop(context);
                      _showReportDialog(entity, viewModel);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showReportDialog(
      DetailPostEntity entity, DetailPostViewModel viewModel) {
    String reportContent = ''; // Variable to store report content

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
                style: kTextContentStyleMiddle.copyWith(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: '신고 내용을 입력하세요...',
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintStyle: kTextContentStyleMiddle.copyWith(
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
                    onPressed: () {
                      _submitReport(entity, viewModel, reportContent);
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

  void _submitReport(DetailPostEntity entity, DetailPostViewModel viewModel,
      String reportContent) async {
    try {
      final reportEntity = ReportEntity(
        type: 'article',
        id: entity.id,
        reportContent: reportContent,
      );

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
      print('Failed to submit report: $error');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('신고 제출 중 오류가 발생했습니다.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _getUserId() async {
    final localStorage = ref.read(localStorageProvider);
    userId = (await localStorage.getUserId())!; // Initialize the userId here
  }

  void _editPost(
      DetailPostEntity entity, DetailPostViewModel viewModel, int type) async {
    String? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditPage(post: entity, viewModel: viewModel, type: type),
      ),
    );
    if (result != null) {
      setState(() {
        entity.content = result;
      });
    }
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
              onPressed: () {},
              child: const Text(
                '취소',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, true);
                viewModel.deletePost(type, entity.id);
                //viewModel.someMethod(type);
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

  void _submitComment(int type, DetailPostEntity entity,
      DetailPostViewModel viewModel, BuildContext context) {
    if (_commentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('댓글 내용을 입력해주세요.'),
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      viewModel.writeComment(entity.id, _commentController.text);
      setState(() {
        _commentController.clear();
        FocusScope.of(context).unfocus();
      });
    }
  }

  String _formatWriteDate(String writeDate) {
    DateTime currentDate = DateTime.now();

    DateTime postDate = DateTime.parse(writeDate);

    String formattedDate;

    if (currentDate.year == postDate.year &&
        currentDate.month == postDate.month &&
        currentDate.day == postDate.day) {
      formattedDate = DateFormat('hh:mm a').format(postDate);
    } else {
      formattedDate = DateFormat('yyyy-MM-dd hh:mm a').format(postDate);
    }

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(detailPostViewModelProvider);
    return viewModel.state is SuccessState
        ? Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: InkWell(
                    onTap: () => _onMoreVertTap(
                        viewModel.detailPostEntity, viewModel, widget.type),
                    child: const Icon(
                      Icons.more_vert,
                    ),
                  ),
                ),
              ],
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
                            padding: const EdgeInsets.only(
                              top: 10.0,
                              left: 16.0,
                              right: 16.0,
                              bottom: 0.0,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    if (viewModel.detailPostEntity.writerImage
                                        .isNotEmpty)
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundImage: NetworkImage(
                                          viewModel
                                              .detailPostEntity.writerImage,
                                        ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              viewModel
                                                  .detailPostEntity.nickName,
                                              style: kTextContentStyleSmall,
                                            ),
                                            const Text(" • "),
                                            Text(
                                              _formatWriteDate(viewModel
                                                  .detailPostEntity.writeDate),
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      viewModel.detailPostEntity.title,
                                      style: kTextContentStyleMiddle,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: kPaddingMiddleSize,
                                ),
                                viewModel.detailPostEntity.photos.isNotEmpty
                                    ? Column(
                                        children: [
                                          Stack(
                                              alignment: Alignment.bottomCenter,
                                              children: <Widget>[
                                                CarouselSlider.builder(
                                                  options: CarouselOptions(
                                                    initialPage: 0,
                                                    viewportFraction: 1,
                                                    enlargeCenterPage: true,
                                                    onPageChanged:
                                                        (index, reason) =>
                                                            setState(() {
                                                      activeIndex = index;
                                                    }),
                                                  ),
                                                  itemCount: viewModel
                                                      .detailPostEntity
                                                      .photos
                                                      .length,
                                                  itemBuilder: (context, index,
                                                      realIndex) {
                                                    final path = viewModel
                                                        .detailPostEntity
                                                        .photos[index];
                                                    return imageSlider(
                                                        path, index);
                                                  },
                                                ),
                                                Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: indicator(viewModel
                                                        .detailPostEntity)),
                                              ]),
                                          const SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      )
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
                                      number: viewModel
                                          .detailPostEntity.comments.length,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    !viewModel.detailPostEntity.isLike
                                        ? InkWell(
                                            onTap: () => viewModel.addLike(
                                                viewModel.detailPostEntity.id),
                                            child: const Icon(
                                                FontAwesomeIcons.heart))
                                        : InkWell(
                                            onTap: () => viewModel.cancelLike(
                                                viewModel.detailPostEntity.id),
                                            child: const Icon(
                                                FontAwesomeIcons.solidHeart),
                                          ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    const Text('좋아요'),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    !viewModel.detailPostEntity.isClipped
                                        ? InkWell(
                                            onTap: () => viewModel.addClip(
                                                viewModel.detailPostEntity.id),
                                            child: const Icon(
                                                Icons.bookmark_border))
                                        : InkWell(
                                            onTap: () => viewModel.cancelClip(
                                                viewModel.detailPostEntity.id),
                                            child: const Icon(Icons.bookmark)),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    const Text('스크랩'),
                                  ],
                                ),
                                const SizedBox(
                                  height: kPaddingSmallSize,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (viewModel.detailPostEntity.comments.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              '댓글이 없습니다.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          )
                        else
                          Container(
                            child: Column(
                              children: viewModel.detailPostEntity.comments
                                  .map((comment) => CommentBox(
                                        articleId:
                                            viewModel.detailPostEntity.id,
                                        content: comment.content,
                                        nickName: comment.nickName,
                                        writeDate: comment.writeDate,
                                        userId: comment.userId,
                                        level: comment.level,
                                        commentId: comment.id,
                                        viewModel: viewModel,
                                        currentUserId: userId,
                                        userImage: comment.userImage,
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
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
                          style: kTextContentStyleMiddle.copyWith(
                              color: Colors.black),
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
                            ? _submitComment(widget.type,
                                viewModel.detailPostEntity, viewModel, context)
                            : null,
                        icon: const Icon(Icons.send, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : const Center(
            child: CircularProgressIndicator(
            color: Colors.white,
          ));
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
