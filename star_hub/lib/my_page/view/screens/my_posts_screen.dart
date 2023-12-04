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
    // entity 값이 변경될 때마다 _setState 메서드 호출
    viewModel.addListener(_setState);
  }

  @override
  void dispose() {
    viewModel.state.removeListener(_setState);
    // dispose 시에 listener 제거
    viewModel.removeListener(_setState);
    super.dispose();
  }

  void _setState() => setState(() {
    print("갱갱신");
  });

  @override
  Widget build(BuildContext context) {
    return ValueStateListener(
      successBuilder: (_, state) {
        if (state.value!.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text('내가 쓴 글'),
            ),
            backgroundColor: Colors.black,
            body: const Center(
              child: Text(
                '글이 없습니다.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text('내가 쓴 글'),
            ),
            backgroundColor: Colors.black,
            body: ListView.builder(
              itemCount: viewModel.entity.length,
              itemBuilder: (BuildContext context, int index) {
                final post = viewModel.entity[index];
                return GestureDetector(
                  onTap: () {},
                  child: PostBox(
                    title: post.title,
                    content: post.content,
                    nickName: widget.nickName,
                    writeDate: post.writeDate,
                    likes: post.likes,
                    clips: null,
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(5, post.articleId, null, myPostState: viewModel.state,),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        }
      },
      state: viewModel.state,
    );
  }
}
