import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/styles/fonts/fonts.dart';
import 'package:star_hub/community/const/tabs.dart';
import 'package:star_hub/community/model/state/state.dart';
import 'package:star_hub/community/view/widgets/post_box2.dart';
import 'package:star_hub/community/view_model/full_post_viewmodel.dart';

import '../widgets/post_box.dart';

class FullPostPage extends ConsumerStatefulWidget {
  const FullPostPage({super.key});

  @override
  ConsumerState<FullPostPage> createState() => _FullPostPageState();
}

class _FullPostPageState extends ConsumerState<FullPostPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(postViewModelProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      body: DefaultTabController(
        length: tabs.length,
        child: Column(
          children: [
            TabBar(
              padding: const EdgeInsets.only(bottom: 15.0),
              controller: _tabController,
              isScrollable: true,
              unselectedLabelColor: Colors.white,
              labelColor: Colors.black,
              indicatorColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              tabs: tabs
                  .map(
                    (e) => Tab(
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            _tabController.animateTo(tabs.indexOf(e));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14.0,
                              vertical: 10.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              border:
                                  Border.all(color: Colors.white, width: 2.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(e.icon),
                                const SizedBox(width: 10),
                                Text(e.label, style: kTextContentStyleSmall),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
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
                      : const Center(child: CircularProgressIndicator()),
                  // 두 번째 탭의 내용
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
                      : const Center(child: CircularProgressIndicator()),
                  // 세 번째 탭의 내용
                  viewModel.state is SuccessState
                      ? ListView.builder(
                          itemCount: viewModel.entity.length,
                          itemBuilder: (context, index) {
                            final post = viewModel.entity[index];
                            return PostBox(
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
                      : const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
