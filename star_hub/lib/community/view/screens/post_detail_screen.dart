import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:star_hub/common/local_storage/local_storage.dart';
import 'package:star_hub/common/styles/fonts/font_style.dart';
import 'package:star_hub/common/styles/sizes/sizes.dart';
import 'package:star_hub/common/value_state_listener.dart';
import 'package:star_hub/community/model/entity/detail_post_entity.dart';
import 'package:star_hub/community/model/state/state.dart';
import 'package:star_hub/community/view/widgets/comment_box.dart';
import 'package:star_hub/community/view/widgets/icon_num.dart';
import 'package:star_hub/community/view_model/detail_post_viewmodel.dart';

import '../../model/entity/comment_entity.dart';
import 'edit_screen.dart';

class DetailPage extends ConsumerStatefulWidget {
  const DetailPage(this.type, this.postId, {Key? key}) : super(key: key);
  final int? type;
  final int postId;

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  late TextEditingController _commentController;
  int activeIndex = 0;
  String newComment = '';
  late final DetailPostViewModel viewModel;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();

    viewModel = ref.read(detailPostViewModelProvider)..getInfo(widget.postId);
  }

  void _onMoreVertTap(
      DetailPostEntity entity, DetailPostViewModel viewModel, int? type) {
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
                    leading: const Icon(Icons.edit),
                    title: const Text('수정하기'),
                    onTap: () {
                      Navigator.pop(context);
                      _editPost(entity, viewModel, type);
                    },
                  ),
                if (true)
                  ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('삭제하기'),
                    onTap: () {
                      Navigator.pop(context);
                      _showDeleteConfirmationDialog(entity, viewModel, type);
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
  }

  void _editPost(
      DetailPostEntity entity, DetailPostViewModel viewModel, int? type) async {
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
        entity.comments.add(CommentEntity(
          content: newComment,
          nickName: 'CurrentUser',
          writeDate: 'Just Now',
          level: 'User Level',
          id: 1,
          userId: 1,
        ));
        _commentController.clear();
        FocusScope.of(context).unfocus();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus(); // 키보드 닫기 이벤트
            },
            child: Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
              ),
              body: ValueStateListener(
                state: viewModel.state,
                successBuilder: (_, state) => Column(
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          state.value!.title,
                                          style: kTextContentStyleMiddle,
                                        ),
                                        InkWell(
                                          onTap: () => _onMoreVertTap(
                                              state.value!,
                                              viewModel,
                                              widget.type),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  state.value!.nickName,
                                                  style: kTextContentStyleSmall,
                                                ),
                                                const Text(" • "),
                                                Text(
                                                  state.value!.writeDate,
                                                  style:
                                                      kTextContentStyleXSmall,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              state.value!.level,
                                              style: kTextSubContentStyleXSmall,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: kPaddingMiddleSize,
                                    ),
                                    state.value!.photos.isNotEmpty
                                        ? Stack(
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
                                                  itemCount: state
                                                      .value!.photos.length,
                                                  itemBuilder: (context, index,
                                                      realIndex) {
                                                    final path = state
                                                        .value!.photos[index];
                                                    return imageSlider(
                                                        path, index);
                                                  },
                                                ),
                                                Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child:
                                                        indicator(state.value!))
                                              ])
                                        : Container(),
                                    Text(
                                      state.value!.content,
                                      style: kTextContentStyleSmall,
                                    ),
                                    const SizedBox(
                                      height: kPaddingMiddleSize,
                                    ),
                                    Row(
                                      children: [
                                        IconWithNumber(
                                          icon: FontAwesomeIcons.heart,
                                          number: state.value!.likes,
                                        ),
                                        IconWithNumber(
                                          icon: Icons.bookmark_border,
                                          number: state.value!.clips,
                                        ),
                                        IconWithNumber(
                                          icon: Icons.messenger_outline,
                                          number: state.value!.comments.length,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        !state.value!.isLike
                                            ? InkWell(
                                                onTap: () => viewModel
                                                    .addLike(state.value!.id),
                                                child: const Icon(
                                                    FontAwesomeIcons.heart))
                                            : InkWell(
                                                onTap: () =>
                                                    viewModel.cancelLike(
                                                        state.value!.id),
                                                child: const Icon(
                                                    FontAwesomeIcons
                                                        .solidHeart),
                                              ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        !state.value!.isClipped
                                            ? InkWell(
                                                onTap: () => viewModel
                                                    .addClip(state.value!.id),
                                                child: const Icon(
                                                    Icons.bookmark_border))
                                            : InkWell(
                                                onTap: () =>
                                                    viewModel.cancelClip(
                                                        state.value!.id),
                                                child:
                                                    const Icon(Icons.bookmark))
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
                                children: state.value!.comments
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
                                ? _submitComment(widget.type, state.value!,
                                    viewModel, context)
                                : null,
                            icon: const Icon(Icons.send, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        //: const Center(child: CircularProgressIndicator());
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
