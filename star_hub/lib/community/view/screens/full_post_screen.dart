import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/community/model/state/state.dart';
import 'package:star_hub/community/view/widgets/post_box2.dart';
import 'package:star_hub/community/view_model/full_post_viewmodel.dart';

class FullPostPage extends ConsumerWidget {
  const FullPostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(postViewModelProvider);
    return DefaultTabController(
      length: 3, // 탭의 개수를 지정
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), // 탭바를 둥근 모양으로 만듭니다.
            ),
            child: TabBar(
              isScrollable: true,
              indicator: const BoxDecoration(
                color: Colors.transparent,
              ),
              labelStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
              unselectedLabelStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
              tabs: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: const Tab(
                    text: '관측도구',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: const Tab(
                    text: '관측장소',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: const Tab(
                    text: '사진자랑',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                // 첫 번째 탭의 내용
                viewModel.state is SuccessState
                    ? ListView.builder(
                  itemCount: viewModel.entity.length,
                  itemBuilder: (context, index) {
                    final post = viewModel.entity[index];
                    return PostBox2(
                      title: post.title,
                      content: post.content,
                      nickName: post.nickName,
                      writeDate: post.writeDate,
                      level: post.level,
                      likes: post.likes,
                      clips: post.clips,
                      comments: post.comments,
                    );
                  },
                )
                    : Center(child: CircularProgressIndicator()),
                // 두 번째 탭의 내용
                Center(child: Text('Tab 2 Content')),
                // 세 번째 탭의 내용
                Center(child: Text('Tab 3 Content')),
                // 추가적인 탭의 내용을 필요에 따라 추가할 수 있습니다.
              ],
            ),
          ),
        ],
      ),
    );
  }
}
