import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/styles/fonts/font_style.dart';
import 'package:star_hub/common/value_state_listener.dart';
import 'package:star_hub/community/view/screens/post_detail_screen.dart';
import 'package:star_hub/my_page/view/widgets/post_box_widget.dart';
import 'package:star_hub/my_page/view_model/my_posts_viewmodel.dart';

class MyPostsPage extends ConsumerStatefulWidget {
  final String nickName;

  const MyPostsPage(this.nickName, {super.key});

  @override
  ConsumerState<MyPostsPage> createState() => _MyPostsPageState();
}

class _MyPostsPageState extends ConsumerState<MyPostsPage> {
  late MyPostViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ref.read(myPostViewModelProvider)..getInfo();
    viewModel.state.addListener(_setState);
  }

  @override
  void dispose() {
    viewModel.state.removeListener(_setState);
    super.dispose();
  }

  void _setState() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            const Text(
              '내가 쓴 글 ',
              style: kTextContentStyleLarge,
            ),
            viewModel.state.isSuccess
                ? Text(
                    viewModel.state.value!.length.toString(),
                    style:
                        kTextContentStyleMiddle.copyWith(color: Colors.yellow),
                  )
                : Container()
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 배경 이미지
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.dstATop,
              ),
              child: Image.asset(
                'assets/back2.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          ValueStateListener(
            state: viewModel.state,
            errorBuilder: (_, state) => Text(state.message),
            noneBuilder: (_, __) => Text("뭐야!"),
            loadingBuilder: (_, __) => Center(
                child: Image.asset(
              'assets/gif/space.gif',
              height: 50.0,
              width: 50.0,
            )),
            successBuilder: (_, state) => state.value!.isEmpty
                ? const Center(
                    child: Text(
                      '글이 없습니다.',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: viewModel.entity.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == viewModel.entity.length) {
                        return Container(
                          height: 30,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1,
                                  ))),
                        );
                      } else {
                      }
                      final post = viewModel.entity[index];
                      return GestureDetector(
                        onTap: () {},
                        child: PostBox(
                          title: post.title,
                          content: post.content,
                          nickName: widget.nickName,
                          writeDate: post.writeDate,
                          likes: post.likes,
                          clips: post.clips,
                          categoryId: post.categoryId,
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  5,
                                  post.articleId,
                                  null,
                                  myPostState: viewModel.state,
                                ),
                              ),
                            ).then((value) {
                              viewModel.getInfo();
                            });
                          },
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
