import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          title: const Text('내가 쓴 글'),
        ),
        backgroundColor: Colors.black,
        body: ValueStateListener(
          state: viewModel.state,
          errorBuilder: (_, state) => Text(state.message),
          noneBuilder: (_, __) => Text("뭐야!"),
          loadingBuilder: (_, __) => const CircularProgressIndicator(
            color: Colors.white,
          ),
          successBuilder: (_, state) => state.value!.isEmpty
              ? const Center(
                  child: Text(
                    '글이 없습니다.',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : ListView.builder(
                  itemCount: viewModel.entity.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == viewModel.entity.length) {
                      // return const Divider(
                      //   color: Colors.white24,
                      //   thickness: 1,
                      // );
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
        ));
  }
}
