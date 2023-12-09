import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/styles/fonts/font_style.dart';
import 'package:star_hub/common/value_state_listener.dart';
import 'package:star_hub/community/view/screens/post_detail_screen.dart';
import 'package:star_hub/my_page/view/widgets/post_box_widget.dart';
import 'package:star_hub/my_page/view_model/my_likes_viewmodel.dart';

class MyLikesPage extends ConsumerStatefulWidget {
  const MyLikesPage({super.key});

  @override
  ConsumerState<MyLikesPage> createState() => _MyLikePageState();
}

class _MyLikePageState extends ConsumerState<MyLikesPage> {
  late MyLikeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ref.read(myLikeViewModelProvider)..getInfo();
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
                '내가 좋아요한 글 ',
                style: kTextContentStyleLarge,
              ),
              viewModel.state.isSuccess
                  ? Text(
                      viewModel.state.value!.length.toString(),
                      style: kTextContentStyleMiddle.copyWith(
                          color: Colors.yellow),
                    )
                  : Container()
            ],
          ),
        ),
        backgroundColor: Colors.black,
        body: ValueStateListener(
          state: viewModel.state,
          loadingBuilder: (_, __) => const CircularProgressIndicator(
            color: Colors.white,
          ),
          successBuilder: (_, state) => state.value!.isEmpty
              ? const Center(
                  child: Text(
                    '좋아요한 글이 없습니다.',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: viewModel.entity.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == viewModel.entity.length) {
                      return Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.white24,
                              width: 1,
                            ),
                          ),
                        ),
                      );
                    }
                    final post = viewModel.entity[index];
                    return GestureDetector(
                      onTap: () {},
                      child: PostBox(
                          categoryId: post.categoryId,
                          title: post.title,
                          content: post.content,
                          nickName: post.nickName,
                          writeDate: post.writeDate,
                          likes: null,
                          clips: null,
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                          6,
                                          post.articleId,
                                          null,
                                          myPostLikeState: viewModel.state,
                                        ))).then((value) {
                              viewModel.getInfo();
                            });
                          }),
                    );
                  },
                ),
        ));
  }
}
