import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:star_hub/common/local_storage/local_storage.dart';
import 'package:star_hub/common/styles/fonts/font_style.dart';
import 'package:star_hub/common/styles/sizes/sizes.dart';
import 'package:star_hub/common/value_state_listener.dart';
import 'package:star_hub/community/model/entity/detail_post_entity.dart';
import 'package:star_hub/community/model/state/state.dart';
import 'package:star_hub/community/view/widgets/button_view.dart';
import 'package:star_hub/community/view/widgets/comment_box.dart';
import 'package:star_hub/community/view/widgets/icon_num.dart';
import 'package:star_hub/community/view_model/detail_post_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/entity/comment_entity.dart';
import '../../model/entity/report_entity.dart';
import '../../model/service/report_service.dart';
import 'edit_screen.dart';
import 'full_image_page.dart';

class DetailPage extends ConsumerStatefulWidget {
  const DetailPage(
    this.type,
    this.postId,
    this.writerId, {
    this.word,
    Key? key,
    this.searchState,
    this.myPostState,
    this.myPostLikeState,
    this.myPostClipState,
    this.scopeCommunityState,
    this.placeCommunityState,
    this.photoCommunityState,
  }) : super(key: key);
  final int? type;
  final int? writerId;
  final int postId;
  final String? word;
  final SearchState? searchState;
  final MyPostState? myPostState;
  final MyPostLikeState? myPostLikeState;
  final MyPostClipState? myPostClipState;
  final ScopeCommunityState? scopeCommunityState;
  final PlaceCommunityState? placeCommunityState;
  final PhotoCommunityState? photoCommunityState;

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  final ScrollController _scrollController = ScrollController();

  late TextEditingController _commentController;
  int activeIndex = 0;
  String newComment = '';

  late final DetailPostViewModel viewModel;
  late Future<String> userId;
  DetailPostEntity? entity = null;
  bool isInit = true;

  @override
  void initState() {
    super.initState();
    setState(() {});
    _commentController = TextEditingController();
    userId = _getUserId();
    viewModel = ref.read(detailPostViewModelProvider)..getInfo(widget.postId);
    viewModel.state.addListener(_setState);
  }

  @override
  void dispose() {
    entity = null;
    viewModel.resetPost();
    viewModel.state.removeListener(_setState);
    super.dispose();
  }

  void _setState() => setState(() {});

  Future<void> _onMoreVertTap(
      DetailPostEntity entity, DetailPostViewModel viewModel, int? type) async {
    String? userIdValue = await userId;
    _showModalBottomSheet(userIdValue, entity, viewModel, type);
  }

  void _showModalBottomSheet(String? userId, DetailPostEntity entity,
      DetailPostViewModel viewModel, int? type) {
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
                if (viewModel.state.value!.writerId.toString() == userId)
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('수정하기'),
                    onTap: () {
                      Navigator.pop(context);
                      _editPost(entity, viewModel, type);
                    },
                  ),
                if (viewModel.state.value!.writerId.toString() == userId)
                  ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('삭제하기'),
                    onTap: () {
                      Navigator.pop(context);
                      _showDeleteConfirmationDialog(entity, viewModel, type);
                    },
                  ),
                if (viewModel.state.value!.writerId.toString() != userId)
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

  TextSpan buildTextWithLinks(BuildContext context, String text) {
    final List<TextSpan> spans = [];

    final RegExp linkRegExp = RegExp(
      r"https?://(?:[a-z0-9\-]+\.)+[a-z]{2,}(?:/[a-z0-9\-._~:/?#[\]@!$&'()*+,;=]*)?",
      caseSensitive: false,
    );

    final Iterable<RegExpMatch> matches = linkRegExp.allMatches(text);

    int lastMatchEnd = 0;

    for (RegExpMatch match in matches) {
      final String linkText = match.group(0)!;
      final int matchStart = match.start;

      if (matchStart > lastMatchEnd) {
        spans.add(
          TextSpan(
            text: text.substring(lastMatchEnd, matchStart),
            style: kTextContentStyleSmall3, // 스타일을 직접 적용
          ),
        );
      }

      spans.add(
        TextSpan(
          text: linkText,
          style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
            fontSize: 14.0,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              _launchURL(context, linkText);
            },
        ),
      );
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastMatchEnd),
          style: kTextContentStyleSmall3,
        ),
      );
    }

    return TextSpan(
      style: kTextContentStyleSmall3, // 스타일을 직접 적용
      children: spans,
    );
  }

  void _launchURL(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
                ],
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

  Future<String> _getUserId() async {
    final localStorage = ref.read(localStorageProvider);
    var userId = await localStorage.getUserId();
    assert(userId != null, 'userId cannot be null');
    return userId!;
  }

  void _editPost(
      DetailPostEntity entity, DetailPostViewModel viewModel, int? type) async {
    String? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPage(
            post: entity,
            viewModel: viewModel,
            type: type,
            scopeCommunityState: widget.scopeCommunityState,
            placeCommunityState: widget.placeCommunityState,
            photoCommunityState: widget.photoCommunityState,
            myPostClipState: widget.myPostClipState,
            myPostLikeState: widget.myPostLikeState,
            myPostState: widget.myPostState,
            searchState: widget.searchState,
            word: widget.word),
      ),
    );
    if (result != null) {
      setState(() {
        entity.content = result;
      });
    }
  }

  void _showDeleteConfirmationDialog(
      DetailPostEntity entity, DetailPostViewModel viewModel, int? type) {
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
                viewModel.deletePost(type, entity.id,
                    word: widget.word,
                    searchState: widget.searchState,
                    myPostClipState: widget.myPostClipState,
                    myPostLikeState: widget.myPostLikeState,
                    myPostState: widget.myPostState,
                    scopeCommunityState: widget.scopeCommunityState,
                    placeCommunityState: widget.placeCommunityState,
                    photoCommunityState: widget.photoCommunityState);
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

  void _submitComment(int? type, DetailPostEntity entity,
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
      Future.delayed(const Duration(milliseconds: 500), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
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
    entity = viewModel.getPost();
    return FutureBuilder<String>(
        future: userId,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Future가 완료되었으므로 snapshot.data를 사용합니다.
            String userId = snapshot.data!;

            return WillPopScope(
                onWillPop: () async {
                  isInit = true;
                  setState(() {
                    entity = null;
                  });
                  Navigator.pop(context, viewModel.state.value);
                  return true;
                },
                child: GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus
                          ?.unfocus(); // 키보드 닫기 이벤트
                    },
                    child: Scaffold(
                        backgroundColor: Colors.black,
                        appBar: AppBar(
                          title: widget.type != null
                              ? widget.type == 1
                                  ? const Text(
                                      "관측도구 게시판",
                                      style: kTextContentStyleLarge,
                                    )
                                  : widget.type == 2
                                      ? const Text("관측장소 게시판",
                                          style: kTextContentStyleLarge)
                                      : widget.type == 3
                                          ? const Text("사진자랑 게시판",
                                              style: kTextContentStyleLarge)
                                          : const Text("")
                              : const Text(""),
                          leading: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              isInit = true;
                              setState(() {
                                entity = null;
                              });
                              Navigator.pop(context, viewModel.state.value);
                            },
                          ),
                          backgroundColor: Colors.black,
                          actions: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: InkWell(
                                onTap: () => _onMoreVertTap(
                                    viewModel.state.value!,
                                    viewModel,
                                    widget.type),
                                child: const Icon(
                                  Icons.more_vert,
                                ),
                              ),
                            ),
                          ],
                        ),
                        body: viewModel.state.isError == true
                            ? AlertDialog(
                                backgroundColor: Colors.black,
                                elevation: 24.0,
                                shape: const RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.white),
                                ),
                                content: Text(
                                  viewModel.state.message,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      '확인',
                                      style: TextStyle(
                                          color: Colors.white), // 버튼 텍스트 색상
                                    ),
                                  ),
                                ],
                              )
                            : entity == null
                                ? Center(
                                    child: Image.asset(
                                    'assets/gif/space.gif',
                                    height: 50.0,
                                    width: 50.0,
                                  ))
                                : Column(
                                    children: [
                                      Expanded(
                                        child: SingleChildScrollView(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          controller: _scrollController,
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 10.0,
                                                    left: 16.0,
                                                    right: 16.0,
                                                    bottom: 0.0,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          if (entity!
                                                                  .writerImage
                                                                  ?.startsWith(
                                                                      'https') ==
                                                              true)
                                                            CircleAvatar(
                                                              radius: 15,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                entity!
                                                                    .writerImage!,
                                                              ),
                                                            )
                                                          else
                                                            const CircleAvatar(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              foregroundColor:
                                                                  Colors.black,
                                                              radius: 15,
                                                              child: Icon(
                                                                Icons.person,
                                                                size: 25,
                                                              ),
                                                            ),
                                                          const SizedBox(
                                                            width:
                                                                kPaddingSmallSize,
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    entity!
                                                                        .nickName,
                                                                    style:
                                                                        kTextContentStyleSmall,
                                                                  ),
                                                                  const Text(
                                                                      " • "),
                                                                  Text(
                                                                    _formatWriteDate(
                                                                        entity!
                                                                            .writeDate),
                                                                    style:
                                                                        kTextContentStyleXSmall,
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                entity!.level,
                                                                style:
                                                                    kTextSubContentStyleXSmall,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height:
                                                            kPaddingMiddleSize,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            entity!.title,
                                                            style:
                                                                kTextContentStyleMiddle,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height:
                                                            kPaddingMiddleSize,
                                                      ),
                                                      entity!.photos.isNotEmpty
                                                          ? Column(
                                                              children: [
                                                                Stack(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomCenter,
                                                                    children: <Widget>[
                                                                      CarouselSlider
                                                                          .builder(
                                                                        options:
                                                                            CarouselOptions(
                                                                          enableInfiniteScroll:
                                                                              false,
                                                                          initialPage:
                                                                              0,
                                                                          viewportFraction:
                                                                              1,
                                                                          enlargeCenterPage:
                                                                              true,
                                                                          onPageChanged: (index, reason) =>
                                                                              setState(() {
                                                                            activeIndex =
                                                                                index;
                                                                          }),
                                                                        ),
                                                                        itemCount: entity!
                                                                            .photos
                                                                            .length,
                                                                        itemBuilder: (context,
                                                                            index,
                                                                            realIndex) {
                                                                          final path =
                                                                              entity!.photos[index];
                                                                          return GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                  builder: (context) => FullImagePage(
                                                                                    imagePaths: entity!.photos,
                                                                                    initialPageIndex: index,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                            child:
                                                                                imageSlider(path, index),
                                                                          );
                                                                        },
                                                                      ),
                                                                      Align(
                                                                          alignment: Alignment
                                                                              .bottomCenter,
                                                                          child:
                                                                              indicator(entity!)),
                                                                    ]),
                                                                const SizedBox(
                                                                  height: 10,
                                                                )
                                                              ],
                                                            )
                                                          : Container(),
                                                      SelectableText.rich(
                                                        buildTextWithLinks(
                                                            context,
                                                            entity!.content),
                                                        style:
                                                            kTextContentStyleSmall3,
                                                      ),
                                                      const SizedBox(
                                                        height:
                                                            kPaddingMiddleSize,
                                                      ),
                                                      Row(
                                                        children: [
                                                          IconWithNumber(
                                                            icon:
                                                                FontAwesomeIcons
                                                                    .heart,
                                                            number:
                                                                entity!.likes,
                                                          ),
                                                          IconWithNumber(
                                                            icon: Icons
                                                                .bookmark_border,
                                                            number:
                                                                entity!.clips,
                                                          ),
                                                          IconWithNumber(
                                                            icon: Icons
                                                                .messenger_outline,
                                                            number: entity!
                                                                .comments
                                                                .length,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          AnimatedIconButton(
                                                            onTap: !entity!
                                                                    .isLike
                                                                ? () => viewModel
                                                                    .addLike(
                                                                        entity!
                                                                            .id)
                                                                : () => viewModel
                                                                    .cancelLike(
                                                                        entity!
                                                                            .id),
                                                            iconData: !entity!
                                                                    .isLike
                                                                ? FontAwesomeIcons
                                                                    .heart
                                                                : FontAwesomeIcons
                                                                    .solidHeart,
                                                            text: "좋아요",
                                                          ),
                                                          AnimatedIconButton(
                                                            onTap: !entity!
                                                                    .isClipped
                                                                ? () => viewModel
                                                                    .addClip(
                                                                        entity!
                                                                            .id)
                                                                : () => viewModel
                                                                    .cancelClip(
                                                                        entity!
                                                                            .id),
                                                            iconData: !entity!
                                                                    .isClipped
                                                                ? Icons
                                                                    .bookmark_border
                                                                : Icons
                                                                    .bookmark, text: '스크랩',
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height:
                                                            kPaddingSmallSize,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              if (entity!.comments.isEmpty)
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
                                                    children: entity!.comments
                                                        .map((comment) =>
                                                            CommentBox(
                                                              articleId:
                                                                  entity!.id,
                                                              content: comment
                                                                  .content,
                                                              nickName: comment
                                                                  .nickName,
                                                              writeDate: comment
                                                                  .writeDate,
                                                              userId: comment
                                                                  .userId,
                                                              level:
                                                                  comment.level,
                                                              commentId:
                                                                  comment.id,
                                                              viewModel:
                                                                  viewModel,
                                                              currentUserId:
                                                                  userId,
                                                              userImage: comment
                                                                  .userImage,
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
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(100),
                                                ],
                                                style: kTextContentStyleMiddle
                                                    .copyWith(
                                                        color: Colors.black),
                                                cursorColor: Colors.black,
                                                decoration: InputDecoration(
                                                  hintText: '댓글을 입력하세요...',
                                                  hintStyle:
                                                      kTextContentStyleMiddle
                                                          .copyWith(
                                                    color: Colors.grey,
                                                  ),
                                                  enabledBorder:
                                                      const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white),
                                                  ),
                                                  focusedBorder:
                                                      const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () =>
                                                  newComment.isNotEmpty
                                                      ? _submitComment(
                                                          widget.type,
                                                          entity!,
                                                          viewModel,
                                                          context)
                                                      : null,
                                              icon: const Icon(Icons.send,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ))));
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          }
        });
  }

  Widget imageSlider(path, index) => Container(
        width: double.infinity,
        height: 400,
        color: Colors.grey[300]?.withOpacity(0.1),
        child: CachedNetworkImage(
            key: Key(path),
            imageUrl: '${path.replaceFirst('https', 'http')}',
            fit: BoxFit.cover),
      );

  Widget indicator(DetailPostEntity entity) {
    if (entity.photos.length <= 1) {
      return Container();
    }
    return Container(
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
}
