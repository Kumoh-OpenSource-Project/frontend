import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:star_hub/common/styles/fonts/font_style.dart';
import 'package:star_hub/common/value_state_listener.dart';
import 'package:star_hub/community/const/tabs.dart';
import 'package:star_hub/community/view/screens/write_post_screen.dart';
import 'package:star_hub/community/view/widgets/post_box2.dart';
import 'package:star_hub/community/view_model/full_post_viewmodel.dart';
import 'package:intl/intl.dart';

import '../../../my_page/model/state.dart';
import '../../../my_page/view_model/my_page_viewmodel.dart';

const limit = "수성";

class FullPostPage extends ConsumerStatefulWidget {
  const FullPostPage({super.key});

  @override
  ConsumerState<FullPostPage> createState() => _FullPostPageState();
}

class _FullPostPageState extends ConsumerState<FullPostPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scopeScrollController = ScrollController();
  final ScrollController _placeScrollController = ScrollController();
  final ScrollController _photoScrollController = ScrollController();
  late PostViewModel viewModel;
  int scopePage = 0;
  int placePage = 0;
  int photoPage = 0;
  int prevList = 10;

  @override
  void initState() {
    super.initState();
    _scopeScrollController.addListener(_scopeScrollListener);
    _placeScrollController.addListener(_placeScrollListener);
    _photoScrollController.addListener(_photoScrollListener);
    _tabController = TabController(length: tabs.length, vsync: this);
    viewModel = ref.read(postViewModelProvider)
      ..getNextPage("scope", scopePage++)
      ..getNextPage("place", placePage++)
      ..getNextPage("photo", photoPage++);
    viewModel.scopeState.addListener(_setState);
    viewModel.placeState.addListener(_setState);
    viewModel.photoState.addListener(_setState);
  }

  @override
  void dispose() {
    viewModel.scopeState.removeListener(_setState);
    viewModel.placeState.removeListener(_setState);
    viewModel.photoState.removeListener(_setState);
    super.dispose();
  }

  void _scopeScrollListener() {
    if (_scopeScrollController.position.pixels ==
        _scopeScrollController.position.maxScrollExtent) {
      print("끝도착");
      _loadMoreData();
    }
  }

  void _placeScrollListener() {
    if (_placeScrollController.position.pixels ==
        _placeScrollController.position.maxScrollExtent) {
      print("끝도착");
      _loadMoreData();
    }
  }

  void _photoScrollListener() {
    if (_photoScrollController.position.pixels ==
        _photoScrollController.position.maxScrollExtent) {
      print("끝도착");
      _loadMoreData();
    }
  }

  String formatTimeDifference(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    DateTime now = DateTime.now();

    Duration difference = now.difference(date);

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
        if (viewModel.getHasNext("scope") == true) {
          viewModel.getNextPage("scope", scopePage++);
        }
        break;
      case "관측장소":
        if (viewModel.getHasNext("place") == true) {
          viewModel.getNextPage("place", placePage++);
        }
        break;
      case "사진자랑":
        if (viewModel.getHasNext("photo") == true) {
          viewModel.getNextPage("photo", photoPage++);
        }
        break;
      default:
        break;
    }
  }

  Future<void> _refreshScope() async {
    scopePage = 0;
    viewModel.refreshData("scope", scopePage++);
    return Future.value();
  }

  Future<void> _refreshPlace() async {
    placePage = 0;
    viewModel.refreshData("place", placePage++);
    return Future.value();
  }

  Future<void> _refreshPhoto() async {
    photoPage = 0;
    viewModel.refreshData("photo", photoPage++);
    return Future.value();
  }

  void _setState() => setState(() {});

  final scopeList = [];
  final placeList = [];
  final photoList = [];

  @override
  Widget build(BuildContext context) {
    final userViewmodel = ref.watch(myPageViewModelProvider);

    if (userViewmodel.state is MyPageStateSuccess) {
      print(userViewmodel.entity.level);
    }

    if (viewModel.scopeList.isEmpty) scopeList.clear();
    if (viewModel.placeList.isEmpty) placeList.clear();
    if (viewModel.photoList.isEmpty) photoList.clear();
    print(prevList == viewModel.scopeList.length);
    print(scopeList != viewModel.scopeList);
    if (viewModel.isScopeReset ||
        prevList != viewModel.scopeList.length ||
        prevList == viewModel.scopeList.length &&
            scopeList != viewModel.scopeList) {
      prevList = viewModel.scopeList.length;
      print("!");
      scopeList.clear();
      scopePage = 1;
      scopeList.addAll(viewModel.scopeList);
      //_scopeScrollController.jumpTo(0.0);
    } else {
      prevList = scopeList.length;
      scopeList.addAll(viewModel.scopeList.where(
        (newItem) =>
            !scopeList.any((existingItem) => existingItem.id == newItem.id),
      ));
    }
    if (viewModel.isPlaceReset) {
      placeList.clear();
      placePage = 1;
      placeList.addAll(viewModel.placeList);
      //_placeScrollController.jumpTo(0.0);
    } else {
      placeList.addAll(viewModel.placeList.where(
        (newItem) =>
            !placeList.any((existingItem) => existingItem.id == newItem.id),
      ));
    }
    if (viewModel.isPhotoReset) {
      photoList.clear();
      photoPage = 1;
      photoList.addAll(viewModel.photoList);
      //
    } else {
      photoList.addAll(viewModel.photoList.where(
        (newItem) =>
            !photoList.any((existingItem) => existingItem.id == newItem.id),
      ));
    }

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
                            if (e.label == "관측장소" &&
                                userViewmodel.state is MyPageStateSuccess &&
                                userViewmodel.entity.level == limit) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "금성 레벨 이상이어야 관측장소를 열람할 수 있습니다.",
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.only(bottom: 520),
                                ),
                              );
                              return;
                            }

                            _tabController.animateTo(tabs.indexOf(e));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14.0,
                              vertical: 10.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              border: Border.all(
                                color: e.label == "관측장소" &&
                                        userViewmodel.state
                                            is MyPageStateSuccess &&
                                        userViewmodel.entity.level == limit
                                    ? Colors.grey
                                    : Colors.white,
                                width: 2.0,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  e.label == "관측장소" &&
                                          userViewmodel.state
                                              is MyPageStateSuccess &&
                                          userViewmodel.entity.level == limit
                                      ? Icons.lock
                                      : e.icon,
                                  color: e.label == "관측장소" &&
                                          userViewmodel.state
                                              is MyPageStateSuccess &&
                                          userViewmodel.entity.level == limit
                                      ? Colors.grey
                                      : null,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  e.label,
                                  style: e.label == "관측장소" &&
                                          userViewmodel.state
                                              is MyPageStateSuccess &&
                                          userViewmodel.entity.level == limit
                                      ? kTextContentStyleSmall.copyWith(
                                          color: Colors.grey)
                                      : kTextContentStyleSmall,
                                ),
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
                  scopeList.isNotEmpty
                      ? RefreshIndicator(
                          color: Colors.white,
                          onRefresh: _refreshScope,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            controller: _scopeScrollController,
                            children: [
                              for (int index = 0;
                                  index < scopeList.length;
                                  index++)
                                PostBox2(
                                  title: scopeList[index].title,
                                  content: scopeList[index].contentText,
                                  nickName: scopeList[index].nickName,
                                  writerId: scopeList[index].writerId,
                                  writeDate: formatTimeDifference(
                                      scopeList[index].writeDate),
                                  level: scopeList[index].level,
                                  likes: scopeList[index].likes,
                                  clips: scopeList[index].clips,
                                  comments: scopeList[index].comments,
                                  onTap: () => viewModel.navigateToDetailPage(
                                    context,
                                    scopeList[index].id,
                                    scopeList[index].categoryId,
                                    scopeList[index].writerId,
                                  ),
                                ),
                              if (viewModel.getHasNext("scope"))
                                const Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                              else
                                Container(
                                  height: 30,
                                ),
                            ],
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        )),
                  placeList.isNotEmpty
                      ? RefreshIndicator(
                          color: Colors.white,
                          onRefresh: _refreshPlace,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            controller: _placeScrollController,
                            children: [
                              for (int index = 0;
                                  index < viewModel.placeList.length;
                                  index++)
                                PostBox2(
                                  writerId: viewModel.placeList[index].writerId,
                                  title: viewModel.placeList[index].title,
                                  content:
                                      viewModel.placeList[index].contentText,
                                  nickName: viewModel.placeList[index].nickName,
                                  writeDate: formatTimeDifference(
                                      viewModel.placeList[index].writeDate),
                                  level: viewModel.placeList[index].level,
                                  likes: viewModel.placeList[index].likes,
                                  clips: viewModel.placeList[index].clips,
                                  comments: viewModel.placeList[index].comments,
                                  onTap: () => viewModel.navigateToDetailPage(
                                    context,
                                    viewModel.placeList[index].id,
                                    viewModel.placeList[index].categoryId,
                                    viewModel.placeList[index].writerId,
                                  ),
                                ),
                              if (viewModel.getHasNext("place"))
                                const Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                              else
                                Container(
                                  height: 30,
                                ),
                            ],
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        )),
                  photoList.isNotEmpty
                      ? RefreshIndicator(
                          color: Colors.white,
                          onRefresh: _refreshPhoto,
                          child: GridView.builder(
                            controller: _photoScrollController,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // 5열
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                            ),
                            itemCount: viewModel.photoList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final post = viewModel.photoList[index];
                              return GestureDetector(
                                onTap: () => viewModel.navigateToDetailPage(
                                    context,
                                    post.id,
                                    post.categoryId,
                                    post.writerId),
                                child: Image.network(
                                  post.photos[0],
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Container(
                                        color:
                                            Colors.grey[300]?.withOpacity(0.1),
                                        width: double.infinity,
                                        height: double.infinity,
                                      );
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        )),
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

    Navigator.of(context)
        .push(_createRoute(selectedCategory, viewModel))
        .then((value) {
      if (selectedCategory == "scope") {
        _scopeScrollController.jumpTo(0.0);
      } else if (selectedCategory == "place") {
        print("1");
        _placeScrollController.jumpTo(0.0);
      } else {
        _photoScrollController.jumpTo(0.0);
      }
    });
  }

  Route _createRoute(String selectedCategory, PostViewModel viewModel) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => WritePostPage(
        selectedCategory: selectedCategory,
        viewModel: viewModel,
        userLevel:
            (ref.watch(myPageViewModelProvider).state is MyPageStateSuccess)
                ? ref.watch(myPageViewModelProvider).entity.level
                : null,
      ),
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
