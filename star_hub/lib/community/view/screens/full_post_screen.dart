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
import 'package:intl/intl.dart';

class FullPostPage extends ConsumerStatefulWidget {
  const FullPostPage({super.key});

  @override
  ConsumerState<FullPostPage> createState() => _FullPostPageState();
}

class _FullPostPageState extends ConsumerState<FullPostPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  ScrollController _scrollController = ScrollController();
  int scopePage = 0;
  int placePage = 0;
  int photoPage = 0;

  bool hasNextScope = true;
  bool hasNextPlace = true;
  bool hasNextPhoto = true;

  //ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _tabController = TabController(length: tabs.length, vsync: this);

  }
  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // 리스트의 마지막에 도달했을 때
      _loadMoreData();

    }
  }
  // void _scrollListener() {
  //
  //   if (_scrollController.offset >= _scrollController.position.maxScrollExtent -1 &&
  //       !_scrollController.position.outOfRange) {
  //     // Reached near the end of the list, load more data
  //
  //   }
  // }
  String formatTimeDifference(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    DateTime now = DateTime.now();

    Duration difference = now.difference(date);
    print(date);
    print(now);
    print(difference);
    print("----");

    if (difference.inDays > 0) {
      return DateFormat('yyyy-MM-dd').format(date);
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }

  Future<void> _loadMoreData() async {
    final viewModel = ref.read(postViewModelProvider);
    String selectedCategory = tabs[_tabController.index].label;
    switch (selectedCategory) {
      case "관측도구":
        if (viewModel.hasNextScope == true) {
          viewModel.getNextPage("scope");
        }
        break;
      case "관측장소":
        viewModel.getNextPage("place");
        break;
      case "사진자랑":
        viewModel.getNextPage("photo");
        break;
      default:
        break;
    }
  }


  Future<void> _refreshData(String type) async {
    final viewModel = ref.read(postViewModelProvider);
    viewModel.resetPage(type); // Reset page(offset) based on the type
    viewModel.getNextPage(type); // Load initial data with offset 0
  }

  Future<void> _refreshScope() async {
    final viewModel = ref.read(postViewModelProvider);
    viewModel.refreshData("scope");
    return Future.value();
  }

  Future<void> _refreshPlace() async {
    final viewModel = ref.read(postViewModelProvider);
    // Call the void function and then return a completed Future<void>
    viewModel.refreshData("place");
    return Future.value();
  }

  Future<void> _refreshPhoto() async {
    final viewModel = ref.read(postViewModelProvider);
    // Call the void function and then return a completed Future<void>
    viewModel.refreshData("scope");
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(postViewModelProvider);
    //viewModel.refreshData("All");
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
                    (e) =>
                    Tab(
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            _tabController.animateTo(tabs.indexOf(e));
                            //viewModel.refreshDataInt(tabs.indexOf(e));
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
                  ?
                  ListView(
                    controller: _scrollController,
                    children: [
                      for (int index = 0; index < viewModel.scopeList.length; index++)
                        PostBox2(
                          title: viewModel.scopeList[index].title,
                          content: viewModel.scopeList[index].contentText,
                          nickName: viewModel.scopeList[index].nickName,
                          writeDate: formatTimeDifference(viewModel.scopeList[index].writeDate),
                          level: viewModel.scopeList[index].level,
                          likes: viewModel.scopeList[index].likes,
                          clips: viewModel.scopeList[index].clips,
                          comments: viewModel.scopeList[index].comments,
                          onTap: () => viewModel.navigateToDetailPage(
                            context,
                            viewModel.scopeList[index].id,
                            viewModel.scopeList[index].categoryId,
                          ),
                        ),
                      if (viewModel.hasNextScope)
                        CircularProgressIndicator(),
                      if (!viewModel.hasNextScope)
                        Container(), // 더 이상 로드할 데이터가 없는 경우
                    ],
                  )



                //     ],
            //   ),
            // )
                : const Center(child: CircularProgressIndicator()),
            viewModel.placeState is SuccessState
                ? RefreshIndicator(
                onRefresh: _refreshPlace,
                child: ListView.builder(
                  itemCount: viewModel.placeEntity.length,
                  itemBuilder: (context, index) {
                    final post = viewModel.placeEntity[index];
                    String formattedTime =
                    formatTimeDifference(post.writeDate);
                    return PostBox2(
                      title: post.title,
                      content: post.contentText,
                      nickName: post.nickName,
                      writeDate: formattedTime,
                      level: post.level,
                      likes: post.likes,
                      clips: post.clips,
                      comments: post.comments,
                      onTap: () =>
                          viewModel.navigateToDetailPage(
                              context, post.id, post.categoryId),
                    );
                  },
                ))
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
                  onTap: () =>
                      viewModel.navigateToDetailPage(
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
    )
    ,
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
          WritePostPage(
              selectedCategory: selectedCategory, viewModel: viewModel),
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
