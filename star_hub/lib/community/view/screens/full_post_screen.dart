import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/const.dart';
import 'package:star_hub/common/dio.dart';
import 'package:star_hub/common/styles/fonts/font_style.dart';
import 'package:star_hub/community/const/tabs.dart';
import 'package:star_hub/community/model/entity/detail_post_entity.dart';
import 'package:star_hub/community/model/entity/photo_post_entity.dart';
import 'package:star_hub/community/model/entity/place_post_entity.dart';
import 'package:star_hub/community/model/repository/community_repository.dart';
import 'package:star_hub/community/model/repository/community_repository.stub.dart';
import 'package:star_hub/community/model/service/post_service.dart';
import 'package:star_hub/community/model/state/state.dart';
import 'package:star_hub/community/view/screens/post_detail_screen.dart';
import 'package:star_hub/community/view/screens/write_post_screen.dart';
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
                  viewModel.scopeState is SuccessState
                      ? ListView.builder(
                          itemCount: viewModel.scopeEntity.length,
                          itemBuilder: (context, index) {
                            final post = viewModel.scopeEntity[index];
                            return PostBox2(
                              title: post.title,
                              content: post.content,
                              nickName: post.nickName,
                              writeDate: post.writeDate,
                              level: post.level,
                              likes: post.likes,
                              clips: post.clips,
                              comments: post.comments,
                              onTap: () => viewModel.navigateToDetailPage(
                                  context, post.id, post.categoryId),
                            );
                          },
                        )
                      : const Center(child: CircularProgressIndicator()),
                  viewModel.placeState is SuccessState
                      ? ListView.builder(
                          itemCount: viewModel.placeEntity.length,
                          itemBuilder: (context, index) {
                            final post = viewModel.placeEntity[index];
                            return PostBox2(
                              title: post.title,
                              content: post.content,
                              nickName: post.nickName,
                              writeDate: post.writeDate,
                              level: post.level,
                              likes: post.likes,
                              clips: post.clips,
                              comments: post.comments,
                              onTap: () => viewModel.navigateToDetailPage(
                                  context, post.id, post.categoryId),
                            );
                          },
                        )
                      : const Center(child: CircularProgressIndicator()),
                  viewModel.photoState is SuccessState
                      ? GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // 5열
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: viewModel.photoEntity.length,
                          itemBuilder: (BuildContext context, int index) {
                            final post = viewModel.photoEntity[index];
                            return GestureDetector(
                              onTap: () => viewModel.navigateToDetailPage(
                                  context, post.id, post.categoryId),
                              child: Image.network(
                                post.photos[0],
                                fit: BoxFit.cover,
                                // loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                //   if (loadingProgress == null) {
                                //     return child; // Image is fully loaded, display it
                                //   } else {
                                //     return Center(
                                //       child: CircularProgressIndicator(), // Display a loading indicator
                                //     );
                                //   }
                                // },
                              ),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          _showWritePostPage(context, viewModel);
        },
        child: Icon(
          PhosphorIcons.pencilSimpleLine(
            PhosphorIconsStyle.duotone,
          ),
          size: 32.0,
        ),
      ),
    );
  }

  void _showWritePostPage(BuildContext context, PostViewModel viewModel) {
    int selectedIndex = _tabController.index;

    String selectedCategory = tabs[selectedIndex].label;

    Map<String, String> categoryMap = {
      '관측도구': 'scope',
      '관측장소': 'place',
      '사진자랑': 'photo',
    };

    selectedCategory = categoryMap[selectedCategory] ?? selectedCategory;

    Navigator.of(context).push(_createRoute(selectedCategory, viewModel));
  }

  Route _createRoute(String selectedCategory, PostViewModel viewModel) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          WritePostPage(selectedCategory: selectedCategory, viewModel: viewModel),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutQuart;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
